//
//  NavigationBarTitleColorFabric.swift
//  PhotoNotes
//
//  Created by Иван Лебедев on 24.03.2020.
//  Copyright © 2020 Иван Лебедев. All rights reserved.
//

import Foundation
import UIKit

enum colorOFTitle:String {
    case blue, green
}
enum StackType:String {
    case Container, Coordinator
}

class Fabric {
    func colorOnTarget() -> UIColor{
    guard let object = Bundle.main.object(forInfoDictionaryKey: "NavigationBarTitleColor") else { fatalError("Unable to Find Color for NavigationBarTitle") }
        
        switch object {
        case let value as String where value == colorOFTitle.blue.rawValue:
            return #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        case let value as String where value == colorOFTitle.green.rawValue:
            return #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        default:
            return #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
        
    }
    func stackOnTarget() -> String {
         guard let objectDate = Bundle.main.object(forInfoDictionaryKey: "StackTypeControl") else {
                   fatalError("Unable to find type for Core Data Stack")
               }
              
               switch objectDate {
               case let value as String where value == StackType.Container.rawValue:
                   return "Container"
               case let value as String where value == StackType.Coordinator.rawValue:
                   return "Coordinator"
               default:
                   return "NoType"
               }
    }
    
}
