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


protocol coreDataFacroty {
    
    func createContext() -> NSManagedObjectContext
    
    func save(imageNew: Data, dateNew: String, realAddress:String, realDescript:String, latitude:String, longitude: String)
    
    
}

import UIKit
import Foundation
import CoreLocation
import MapKit
import CoreData

class CellViewModel {
    private var cells = [Cell]()
    weak var delegate:ModelDelegate?
    var fabric = Fabric()
    
    
   // private var managedCoreCoordinator = CoreCoordinator()
    
    func createCell (imageNew: UIImage, dateNew: String, realAddress:String, realDescript:String, realMapCoord:CLLocationCoordinate2D) {
    
        cells.append(Cell(newImage: imageNew, newDate: dateNew, newAddress: realAddress,newDescript: realDescript, newLatitude: realMapCoord.latitude, newLongitude: realMapCoord.longitude ))
        
      
        
        delegate?.cellsDidUpdate()
        guard let imageToSave = imageNew.pngData() else {return}
        let coreData = fabric.stackOnTarget()
        coreData.save(imageNew: imageToSave , dateNew: dateNew, realAddress: realAddress, realDescript: realDescript, latitude: realMapCoord.latitude.description, longitude: realMapCoord.longitude.description)
        
    }
    
    func updateDescript(newDescription:String, newIndex:IndexPath) {
        let index = newIndex.row
        cells[index].descript = newDescription
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
        return CellViewModelSecondVC(newDescr: cells[index].descript, newImage: cells[index].photo, newIndexPath: indexPath, newMapCoordinates: CLLocationCoordinate2D(latitude: cells[index].MapCoord.latitude, longitude: cells[index].MapCoord.longitude), newAddr: cells[index].address )
    }
    
    
    
    func someFunc(with creator: coreDataFacroty) {
        
        
        
        
    }
    
    func fetchFromCoreData() -> [NSManagedObject] {
        var dateToReveal: [NSManagedObject] = []
        
        
        let managedcontext = fabric.stackOnTarget().createContext()//appdelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "TableCell")
        
        do {
            dateToReveal = try managedcontext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        return dateToReveal
    }
   
  }

//extension coreDataFacroty{
//    func chooseFactory(<#parameters#>) -> <#return type#> {
//        <#function body#>
//    }
//}



