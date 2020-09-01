//
//  CoreController.swift
//  PhotoNotes
//
//  Created by Иван Лебедев on 31.03.2020.
//  Copyright © 2020 Иван Лебедев. All rights reserved.
//

import Foundation
import CoreData

class CoreCoordinator:CoreDataStackBase {

    
    private(set) var mainContext = NSManagedObjectContext.init(concurrencyType: .mainQueueConcurrencyType)
    private let privateContext = NSManagedObjectContext.init(concurrencyType: .privateQueueConcurrencyType)
    
    init() {
        let modelURL = Bundle.main.url(forResource: "PhotoModel", withExtension: "momd")
        guard let model = NSManagedObjectModel(contentsOf: modelURL!) else {
            fatalError("Unable to find Data Model")
        }
        
        let psc = NSPersistentStoreCoordinator(managedObjectModel: model)
        let storeURL = try! FileManager
            .default
            .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            .appendingPathComponent("PhotoModel.sqlite")
        
        try! psc.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: nil)
        let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        context.persistentStoreCoordinator = psc
        
        self.mainContext = context
//        self.privateContext.parent = self.mainContext
//        self.privateContext.automaticallyMergesChangesFromParent = true
    }
    
    func getContext () -> NSManagedObjectContext{
        
        
        return self.mainContext
    }
    
    func save(imageNew: Data, dateNew: String, realAddress: String, realDescript: String, latitude: Double, longitude: Double, index: IndexPath?, newDescr: String) -> TableCell {
        
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "TableCell", in: self.privateContext) else {fatalError("Can't find entity")}
        
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(contextDidSave(_:)), name: Notification.Name.NSManagedObjectContextDidSave, object: self.privateContext)
        
//        NotificationCenter.default.addObserver(self, selector: #selector(contextDidChange(_:)), name: Notification.Name.NSManagedObjectContextObjectsDidChange, object: self.privateContext)
        let managedCell = TableCell(entity: entityDescription, insertInto: self.privateContext)
        
       
        
        self.privateContext.performAndWait {
            
        managedCell.setValue(dateNew, forKeyPath: "date")
        managedCell.setValue(imageNew, forKeyPath: "photo")
        managedCell.setValue(realAddress, forKeyPath: "address")
        managedCell.setValue(realDescript, forKeyPath: "descr")
        managedCell.setValue(longitude, forKeyPath: "longitude")
        managedCell.setValue(latitude, forKey: "latitude")
            
            do {
              try self.privateContext.save()
                
            } catch let error as NSError {
              print("Could not save. \(error), \(error.userInfo)")
            }
        }
        return managedCell
    }
    
    func getDataFromContext() -> [TableCell]   {
        var dateToReveal: [TableCell] = []
        let fetchRequest = NSFetchRequest<TableCell>(entityName: "TableCell")
        
        do{
            dateToReveal = try self.mainContext.fetch(fetchRequest)
        }catch let error as NSError{
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return dateToReveal
    }
    
    @objc func contextDidSave(_ notification: Notification){
        
        self.mainContext.perform {
            self.mainContext.mergeChanges(fromContextDidSave: notification)
          do {
              try self.mainContext.save()
                
            } catch let error as NSError {
              print("Could not save. \(error), \(error.userInfo)")
            }
        }
        
    }
   
}

