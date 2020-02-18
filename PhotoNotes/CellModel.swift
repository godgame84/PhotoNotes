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
    init(newImage: UIImage, newDate: String, newAddress: String) {
        self.photo = newImage
        self.date = newDate
        self.address = newAddress
    }
}



