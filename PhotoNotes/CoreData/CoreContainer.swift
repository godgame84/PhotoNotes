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
    
    // - MARK: Private properties
    
    private var fetchSortDescriptor = NSSortDescriptor(key: #keyPath(TableCell.date), ascending: true)
    
    private var modelName: String
    
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
    
    init() {
              
              self.modelName = "PhotoModel"

              }

    func getContext () -> NSManagedObjectContext{
        return self.mainContext
    }
    
    func getDataFromContext() -> [TableCell] {
          var dateToReveal: [TableCell] = []
                  
          let managedContext = self.mainContext
          
        let fetchRequest : NSFetchRequest<TableCell> = TableCell.fetchRequest()
//        fetchRequest.sortDescriptors = [self.fetchSortDescriptor]
          do {
              dateToReveal = try managedContext.fetch(fetchRequest)
          }   catch let error as NSError{
              print("Could not fetch. \(error), \(error.userInfo)")
          }
          
          return dateToReveal
      }
      
      func save(imageNew: Data, dateNew: String, realAddress: String, realDescript: String, latitude: Double, longitude: Double, index: IndexPath?, newDescr:String) -> TableCell {

        let entityDescr = NSEntityDescription.entity(forEntityName: "TableCell", in: self.mainContext)!
        let managedCell = TableCell(entity: entityDescr, insertInto: self.mainContext)
        
        managedCell.address = realAddress
        managedCell.date = dateNew
        managedCell.descr = realDescript
        managedCell.latitude = latitude
        managedCell.longitude = longitude
        managedCell.photo = imageNew

        do {
            try self.mainContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        return managedCell
      }
}


