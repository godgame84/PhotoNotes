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
    
    
    private var mainContext = NSManagedObjectContext.init(concurrencyType: .mainQueueConcurrencyType)
    let privateContext = NSManagedObjectContext.init(concurrencyType: .privateQueueConcurrencyType)
    
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
        self.privateContext.parent = self.mainContext
    }
    
    func getContext () -> NSManagedObjectContext{
        
        
        return self.mainContext
    }
    func save(imageNew: Data, dateNew: String, realAddress: String, realDescript: String, latitude: Double, longitude: Double) -> NSManagedObject {
        
        NotificationCenter.default.addObserver(self, selector: #selector(contextDidSave(_:)), name: Notification.Name.NSManagedObjectContextDidSave, object: self.mainContext)
        

        guard let entityDescription = NSEntityDescription.entity(forEntityName: "TableCell", in: self.mainContext) else {fatalError("Can't find entity")}
        
        let managedCell = NSManagedObject(entity: entityDescription, insertInto: self.mainContext)
        
        self.mainContext.performAndWait {
            
        managedCell.setValue(dateNew, forKeyPath: "date")
        managedCell.setValue(imageNew, forKeyPath: "photo")
        managedCell.setValue(realAddress, forKeyPath: "address")
        managedCell.setValue(realDescript, forKeyPath: "descr")
        managedCell.setValue(longitude, forKeyPath: "longitude")
        managedCell.setValue(latitude, forKey: "latitude")
            
            do {
              try self.mainContext.save()
                
            } catch let error as NSError {
              print("Could not save. \(error), \(error.userInfo)")
            }
        }
        return managedCell
    }
    func updateDescriptionOnFirstVC(newDescription:String, newIndex:IndexPath) {
            NotificationCenter.default.addObserver(self, selector: #selector(contextDidChange(_:)), name: Notification.Name.NSManagedObjectContextObjectsDidChange, object: self.mainContext)
            var dateToUpdate: [NSManagedObject] = []
            let managedcontext = self.mainContext//appdelegate.persistentContainer.viewContext

            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "TableCell")

            do {
                dateToUpdate = try managedcontext.fetch(fetchRequest)
                dateToUpdate[newIndex.row].setValue(newDescription, forKeyPath: "descr")
            } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            }
        do{
            try self.mainContext.save()
        } catch let error as NSError{
            print("Could not save afte update. \(error),\(error.userInfo)")
        }
        
    }
    @objc func contextDidChange(_ notififcation: Notification){
        
        self.mainContext.perform {
            do{
            try self.mainContext.save()
            } catch let error as NSError{
                print("Could not save afte update.\(error),\(error.userInfo)")
            }
        }
    }
    
    @objc func contextDidSave(_ notification: Notification){
        
        self.privateContext.perform {
            self.privateContext.mergeChanges(fromContextDidSave: notification)
        }
        
    }
}

