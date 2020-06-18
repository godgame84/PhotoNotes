//
//  CoreContainer.swift
//  PhotoNotes
//
//  Created by Иван Лебедев on 31.03.2020.
//  Copyright © 2020 Иван Лебедев. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreContainer:CoreDataStackBase {
    private var modelName: String
    
    init() {
            
            self.modelName = "PhotoModel"

    //         guard let apppDelegate = UIApplication.shared.delegate as? AppDelegate else {
    //                    self.mainContext = NSManagedObjectContext.init(concurrencyType: NSManagedObjectContextConcurrencyType.mainQueueConcurrencyType)
    //                    return
    //               }
    //
    //               let managedContext = apppDelegate.persistentContainer.viewContext
    //
    //
    //
    //            self.mainContext = managedContext
    //        return
            }
    
   
    
    private lazy var mainContext : NSManagedObjectContext = {
        return self.storeContainer.viewContext
    }()
    
    private lazy var storeContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: self.modelName)
        container.loadPersistentStores  { (storeDescription, error) in
            if  let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    

    func getContext () -> NSManagedObjectContext{
        return self.mainContext
    }
    
    func getDataFromContext() -> [NSManagedObject] {
          var dateToReveal: [NSManagedObject] = []
                  
          let managedContext = self.mainContext
          
         // let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "TableCell")
        let fetchRequest : NSFetchRequest<TableCell> = TableCell.fetchRequest()
          do {
              dateToReveal = try managedContext.fetch(fetchRequest)
          }   catch let error as NSError{
              print("Could not fetch. \(error), \(error.userInfo)")
          }
          
          return dateToReveal
      }
      
      func save(imageNew: Data, dateNew: String, realAddress: String, realDescript: String, latitude: Double, longitude: Double, index: Int?, newDescr:String) -> NSManagedObject {
          
//        let entity = NSEntityDescription.entity(forEntityName: "TableCell", in: self.mainContext)!

        let managedCell = TableCell(context:self.mainContext)
        
//        let managedCell = NSManagedObject(entity: entity, insertInto: self.mainContext)
         
        managedCell.address = realAddress
        managedCell.date = dateNew
        managedCell.descr = realDescript
        managedCell.latitude = latitude
        managedCell.longitude = longitude
        managedCell.photo = imageNew
//        managedCell.setValue(dateNew, forKeyPath: "date")
//        managedCell.setValue(imageNew, forKeyPath: "photo")
//        managedCell.setValue(realAddress, forKeyPath: "address")
//        managedCell.setValue(realDescript, forKeyPath: "descr")
//        managedCell.setValue(longitude, forKeyPath: "longitude")
//        managedCell.setValue(latitude, forKey: "latitude")
        
        do {
            try self.mainContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        return managedCell
      }
      






}


