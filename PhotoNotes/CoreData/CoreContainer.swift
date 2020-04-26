//
//  CoreContainer.swift
//  PhotoNotes
//
//  Created by Иван Лебедев on 31.03.2020.
//  Copyright © 2020 Иван Лебедев. All rights reserved.
//

import Foundation
import CoreData

class CoreContainer:CoreDataStackBase {
    func getDataFromContext() -> [NSManagedObject] {
        let dateToReveal: [NSManagedObject] = []
        return dateToReveal
    }
    
    
    func save(imageNew: Data, dateNew: String, realAddress: String, realDescript: String, latitude: Double, longitude: Double, index: Int?, newDescr:String) -> NSManagedObject {
        return NSManagedObject(context: NSManagedObjectContext.init(concurrencyType: .mainQueueConcurrencyType))
    }
    
    
    private var mainContext : NSManagedObjectContext?
    
    init() {
        
        let container = NSPersistentContainer(name: "PhotoModel")
        
        container.loadPersistentStores(completionHandler: {
            NSPersistentStoreDescription, error in
            guard error == nil else{
                fatalError("Failed to load store: \(String(describing: error))")
            }
            self.mainContext = container.viewContext
            
        })
        }

    func getContext () -> NSManagedObjectContext{
        return self.mainContext!
    }







}


