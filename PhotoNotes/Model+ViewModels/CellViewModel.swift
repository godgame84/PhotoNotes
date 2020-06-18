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
    
    func save(imageNew: Data, dateNew: String, realAddress:String, realDescript:String, latitude:Double, longitude: Double, index: Int?, newDescr: String) -> TableCell

    func getDataFromContext() -> [TableCell]
}

import UIKit
import Foundation
import CoreLocation
import MapKit
import CoreData

class CellViewModel {

    // - MARK: Public properties
    
    weak var delegate:ModelDelegate?
    
    public var sendDataToVC: ((_ managedcell:NSManagedObject)->())?
    
    public var updateDescriptionOnFVC: ((_ managedDescript:String, _ index: Int)->())?
    
    var getDateFormatter: DateFormatter  {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "ru_RUS")
        dateFormatter.setLocalizedDateFormatFromTemplate("dd-YYYY-MM")
        return dateFormatter
    }
    
    // - MARK: Private properties
    
    private var fabric = CoreDataStackFactory()
    
    // - MARK: Public methods
    
    func createCell (imageNew: UIImage, dateNew: String, realAddress:String, realDescript:String, realMapCoord:CLLocationCoordinate2D) {
    
        guard let imageToSave = imageNew.pngData() else {return}
        
        let managedCellFromCore = CoreDataStackFactory().stackOnTarget().save(imageNew: imageToSave , dateNew: dateNew, realAddress: realAddress, realDescript: realDescript, latitude: realMapCoord.latitude, longitude: realMapCoord.longitude, index: nil, newDescr: "String")
        
        sendDataToVC?(managedCellFromCore)
        
        delegate?.cellsDidUpdate()
        
    }
    
    func updateDescript(newDescription:String, newIndex:IndexPath) {
        CoreDataStackFactory().stackOnTarget().save(imageNew: Data(), dateNew: "", realAddress: "", realDescript: "", latitude: 0, longitude: 0, index: newIndex.row, newDescr: newDescription)
        
        updateDescriptionOnFVC?(newDescription,newIndex.row)
        
        delegate?.cellsDidUpdate()
    }
    
    func getDate( for indexPath: IndexPath) -> String  {
        return fabric.stackOnTarget().getDataFromContext()[indexPath.row].value(forKeyPath: "date") as! String
    }
    
    func getImage( for indexPath: IndexPath) -> UIImage  {
        return UIImage(data: fabric.stackOnTarget().getDataFromContext()[indexPath.row].value(forKeyPath: "photo") as! Data)!
      }
    func getAddress(for indexPath: IndexPath) -> String {
         return fabric.stackOnTarget().getDataFromContext()[indexPath.row].value(forKeyPath: "address") as! String
    }
     func getDescript(for indexPath: IndexPath) -> String {
        return fabric.stackOnTarget().getDataFromContext()[indexPath.row].value(forKeyPath: "descr") as! String
       }
    
    
    func createDetailViewModel(for indexPath:IndexPath) ->CellViewModelSecondVC  {
        let index = indexPath.row
        let dataFromCore = fetchFromCoreData()
        let cellFromCore = dataFromCore[index]
        return CellViewModelSecondVC(newDescr: cellFromCore.value(forKeyPath: "descr") as? String ?? "", newImage: UIImage(data: cellFromCore.value(forKeyPath: "photo") as! Data) ?? #imageLiteral(resourceName: "Image"), newIndexPath: indexPath, newMapCoordinates: CLLocationCoordinate2D(latitude: (cellFromCore.value(forKeyPath: "latitude")) as! CLLocationDegrees, longitude: cellFromCore.value(forKeyPath: "longitude") as! CLLocationDegrees), newAddr: cellFromCore.value(forKeyPath: "address") as! String )
    }
    
    
    
    func fetchFromCoreData() -> [TableCell] {
        return fabric.stackOnTarget().getDataFromContext()
    }
  }




