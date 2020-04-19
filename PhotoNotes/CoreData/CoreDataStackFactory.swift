//
//  NavigationBarTitleColorFabric.swift
//  PhotoNotes
//
//  Created by Иван Лебедев on 24.03.2020.
//  Copyright © 2020 Иван Лебедев. All rights reserved.
//

import Foundation
import UIKit


enum StackType:String {
    case Container, Coordinator
}



class CoreDataStackFactory {
        

    func stackOnTarget() -> CoreDataStackBase {
         guard let objectDate = Bundle.main.object(forInfoDictionaryKey: "StackTypeControl") else {
                   fatalError("Unable to find type for Core Data Stack")
               }
              
               switch objectDate {
               case let value as String where value == StackType.Container.rawValue:
                   return CoreContainer()
               case let value as String where value == StackType.Coordinator.rawValue:
                   return CoreCoordinator()
               default:
                   return CoreCoordinator()
               }
    }
    
    
}

