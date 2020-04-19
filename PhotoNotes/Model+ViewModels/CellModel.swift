//
//  Cell.swift
//  PhotoNotes
//
//  Created by Иван Лебедев on 02.12.2019.
//  Copyright © 2019 Иван Лебедев. All rights reserved.
//

import Foundation
import UIKit

class Cell {
    var photo : UIImage
    var date : String
    var address : String
    var MapCoord: (latitude:Double, longitude: Double)
    var descript: String
    init(newImage: UIImage, newDate: String, newAddress: String, newDescript:String, newLatitude: Double, newLongitude: Double) {
        self.photo = newImage
        self.date = newDate
        self.address = newAddress
        self.descript = newDescript
        self.MapCoord = (newLatitude, newLongitude)
    }
}



