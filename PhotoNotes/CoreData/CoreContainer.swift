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
          
        let fetchRequest : NSFetchRequest<TableCell> = TableCell.fetchRequest()
//        fetchRequest.sortDescriptors = [self.fetchSortDescriptor]
          do {
            dateToReveal = try self.mainContext.fetch(fetchRequest)
          }   catch let error as NSError{
              print("Could not fetch. \(error), \(error.userInfo)")
          }
          
          return dateToReveal
      }
      
      func save(imageNew: Data, dateNew: String, realAddress: String, realDescript: String, latitude: Double, longitude: Double, index: IndexPath?, newDescr:String) -> TableCell {

     
        let managedCell = TableCell(context: self.mainContext)
        
        if index != nil {
            guard self.mainContext.hasChanges else {
                return managedCell
            }
            do {
                try self.mainContext.save()
            } catch let error as NSError {
                print("Can't save after change. \(error), \(error.userInfo)")
                
            }
            return managedCell
        }
        
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


