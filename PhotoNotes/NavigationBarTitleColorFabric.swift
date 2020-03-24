//
//  NavigationBarTitleColorFabric.swift
//  PhotoNotes
//
//  Created by Иван Лебедев on 24.03.2020.
//  Copyright © 2020 Иван Лебедев. All rights reserved.
//

import Foundation
import UIKit

class fabric {
    func colorOnTarget() -> UIColor{
    guard let object = Bundle.main.object(forInfoDictionaryKey: "NavigationBarTitleColor") else { fatalError("Unable to Find Color for NavigationBarTitle") }
        
        switch object as! String {
        case "blue":
            return #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        case "green":
            return #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        default:
            return #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
        
    }
    
}
