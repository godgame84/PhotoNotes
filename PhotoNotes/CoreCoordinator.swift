//
//  CoreController.swift
//  PhotoNotes
//
//  Created by Иван Лебедев on 31.03.2020.
//  Copyright © 2020 Иван Лебедев. All rights reserved.
//

import Foundation
import CoreData

class CoreCoordinator:coreDataFacroty {
    func save(imageNew: Data, dateNew: String, realAddress: String, realDescript: String, latitude: String, longitude: String) {
        let managedcontext = createContext()//appdelegate.persistentContainer.viewContext
                      
        guard let entity = NSEntityDescription.entity(forEntityName: "TableCell", in: managedcontext) else{
          return
        }

        let managedCell = NSManagedObject(entity: entity, insertInto: managedcontext)

        managedCell.setValue(dateNew, forKeyPath: "date")
        managedCell.setValue(imageNew, forKeyPath: "photo")
        managedCell.setValue(realAddress, forKeyPath: "address")
        managedCell.setValue(realDescript, forKeyPath: "descr")
        managedCell.setValue(longitude, forKeyPath: "longitude")
        managedCell.setValue(latitude, forKey: "latitude")
        
        
        do {
          try managedcontext.save()
        } catch let error as NSError {
          print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    
    func createContext()->NSManagedObjectContext {
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
        return context
    }
}

