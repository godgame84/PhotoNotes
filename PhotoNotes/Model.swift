//
//  Model.swift
//  PhotoNotes
//
//  Created by Иван Лебедев on 20/09/2019.
//  Copyright © 2019 Иван Лебедев. All rights reserved.
//
import UIKit

protocol ModelDelegate: class {
    func cellsDidUpdate()
}



//protocol ModelProtocol: class {
//    var cells: String { get set }
//}


import Foundation
import UIKit

class Model {
    var cells = ["2"]
    var cellImage :[UIImage?] = [nil]
    var imagePicker: ImagePicker!
   
  //  var cells = [Cell]()
    weak var delegate:ModelDelegate?
    
    
    func createCell (_ sender: UIButton) {
        self.imagePicker?.present(from: sender)
        cells.append("Date")
        delegate?.cellsDidUpdate()
    }
    
    
    func getCountOfRows() -> Int {
        return cells.count
    }

   
  }

extension Model: ImagePickerDelegate{
   func didSelect(image: UIImage) {
         cellImage.append(image)
     }
   }

