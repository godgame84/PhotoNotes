//
//  Model.swift
//  PhotoNotes
//
//  Created by Иван Лебедев on 20/09/2019.
//  Copyright © 2019 Иван Лебедев. All rights reserved.
//


protocol ModelDelegate: class {
    func cellsDidUpdate()
}


protocol CoreDataStackBase {
    
    func getContext() -> NSManagedObjectContext
    
    func save(imageNew: Data, dateNew: String, realAddress:String, realDescript:String, latitude:Double, longitude: Double, index: Int?, newDescr: String) -> NSManagedObject

    func getDataFromContext() -> [NSManagedObject]
}

import UIKit
import Foundation
import CoreLocation
import MapKit
import CoreData

class CellViewModel {
    private var cells = [Cell]()
    weak var delegate:ModelDelegate?
    private var fabric = CoreDataStackFactory()
    
    public var sendDataToVC: ((_ managedcell:NSManagedObject)->())?
    
    func createCell (imageNew: UIImage, dateNew: String, realAddress:String, realDescript:String, realMapCoord:CLLocationCoordinate2D) {
    
        cells.append(Cell(newImage: imageNew, newDate: dateNew, newAddress: realAddress,newDescript: realDescript, newLatitude: realMapCoord.latitude, newLongitude: realMapCoord.longitude ))
        
        guard let imageToSave = imageNew.pngData() else {return}
        
        let managedCellFromCore = CoreDataStackFactory().stackOnTarget().save(imageNew: imageToSave , dateNew: dateNew, realAddress: realAddress, realDescript: realDescript, latitude: realMapCoord.latitude, longitude: realMapCoord.longitude, index: nil, newDescr: "String")
        
        sendDataToVC?(managedCellFromCore)
        
        delegate?.cellsDidUpdate()
        
    }
    
    func updateDescript(newDescription:String, newIndex:IndexPath) {
        let updatedCell = CoreDataStackFactory().stackOnTarget().save(imageNew: Data(), dateNew: "", realAddress: "", realDescript: "", latitude: 0, longitude: 0, index: newIndex.row, newDescr: newDescription)
        delegate?.cellsDidUpdate()
    }
    
    func getDate( for indexPath: IndexPath) -> String  {
        let index = indexPath.row
        return cells[index].date.description
    }
    
    func getImage( for indexPath: IndexPath) -> UIImage  {
          let index = indexPath.row
          return cells[index].photo
      }
    func getAddress(for indexPath: IndexPath) -> String {
        let index = indexPath.row
        return cells[index].address
    }
     func getDescript(for indexPath: IndexPath) -> String {
           let index = indexPath.row
           return cells[index].descript
       }
    
    func getCountOfRows() -> Int {
        return cells.count
    }
    func createDetailViewModel(for indexPath:IndexPath) ->CellViewModelSecondVC  {
        let index = indexPath.row
        let dataFromCore = fetchFromCoreData()
        let cellFromCore = dataFromCore[index]
        return CellViewModelSecondVC(newDescr: cellFromCore.value(forKeyPath: "descr") as? String ?? "", newImage: UIImage(data: cellFromCore.value(forKeyPath: "photo") as! Data) ?? #imageLiteral(resourceName: "Image"), newIndexPath: indexPath, newMapCoordinates: CLLocationCoordinate2D(latitude: (cellFromCore.value(forKeyPath: "latitude")) as! CLLocationDegrees, longitude: cellFromCore.value(forKeyPath: "longitude") as! CLLocationDegrees), newAddr: cellFromCore.value(forKeyPath: "address") as! String )
    }
    
    
    
    func fetchFromCoreData() -> [NSManagedObject] {
        return fabric.stackOnTarget().getDataFromContext()
    }
  }

//extension coreDataFacroty{
//    func chooseFactory(<#parameters#>) -> <#return type#> {
//        <#function body#>
//    }
//}



