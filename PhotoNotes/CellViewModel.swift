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

import UIKit
import Foundation
import CoreLocation
import MapKit
import CoreData

class CellViewModel {
    private var cells = [Cell]()
    weak var delegate:ModelDelegate?
    private var coreCoordDel = CoreCoordinator()
    
   // private var managedCoreCoordinator = CoreCoordinator()
    
    func createCell (imageNew: UIImage, textNew: String, realAddress:String, realDescript:String, realMapCoord:CLLocationCoordinate2D) {
    
        cells.append(Cell(newImage: imageNew, newDate: textNew, newAddress: realAddress,newDescript: realDescript, newLatitude: realMapCoord.latitude, newLongitude: realMapCoord.longitude ))
        save(textNew: textNew)
        delegate?.cellsDidUpdate()
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
    
    func save(/*imageNew: UIImage,*/ textNew: String/*, realAddress:String, realDescript:String, realMapCoord:CLLocationCoordinate2D*/) {
//        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else{
//            return
//        }
        
        let managedcontext = coreCoordDel.initializeModel()//appdelegate.persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: "TableCell", in: managedcontext) else{
            return
        }
        
        let managedCell = NSManagedObject(entity: entity, insertInto: managedcontext)
        
        managedCell.setValue(textNew, forKeyPath: "date")
        
        do {
            try managedcontext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func fetchFromCoreData() -> [NSManagedObject] {
        var dateToReveal: [NSManagedObject] = []
//        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else{
//            return dateToReveal
//        }
        
        
        let managedcontext = coreCoordDel.initializeModel()//appdelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "TableCell")
        
        do {
            dateToReveal = try managedcontext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        return dateToReveal
    }
   
  }


