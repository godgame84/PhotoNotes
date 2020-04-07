//
//  AppDelegate.swift
//  PhotoNotes
//
//  Created by Иван Лебедев on 20/09/2019.
//  Copyright © 2019 Иван Лебедев. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

//    func applicationWillTerminate(_ application: UIApplication) {
//        self.save()
//    }
//
//    lazy var persistentContainer: NSPersistentContainer = {
//        let container = NSPersistentContainer(name: "PhotoModel")
//        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
//                   if let error = error as NSError? {
//                       fatalError("Unresolved error \(error),\(error.userInfo)")
//                   }
//               })
//               return container
//
//    }()
//
//    func save(){
//        let context = persistentContainer.viewContext
//        if context.hasChanges{
//            do{
//                try context.save()
//            } catch {
//                let nserror = error as NSError
//                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//            }
//        }
//    }
}

