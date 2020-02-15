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
    var date = DateFormatter()
    init(newImage: UIImage, newDate: DateFormatter) {
        date.dateStyle = .medium
        date.timeStyle = .none
        date.locale = Locale(identifier: "en_US")
        self.photo = newImage
        self.date = newDate
    }
}



