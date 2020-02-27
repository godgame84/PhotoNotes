//
//  Cell.swift
//  PhotoNotes
//
//  Created by Иван Лебедев on 02.12.2019.
//  Copyright © 2019 Иван Лебедев. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class Cell {
    var photo : UIImage
    var date : String
    var address : String
    var MapCoord: CLLocationCoordinate2D
    var descript: String
    init(newImage: UIImage, newDate: String, newAddress: String, newDescript:String, newCoord:CLLocationCoordinate2D) {
        self.photo = newImage
        self.date = newDate
        self.address = newAddress
        self.descript = newDescript
        self.MapCoord = newCoord
    }
}



