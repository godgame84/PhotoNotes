//
//  Model.swift
//  PhotoNotes
//
//  Created by Иван Лебедев on 20/09/2019.
//  Copyright © 2019 Иван Лебедев. All rights reserved.
//


protocol ModelDelegate: class {
    func cellsDidUpdate()
}



//protocol ModelProtocol: class {
//    var cells: String { get set }
//}

import UIKit
import Foundation

class CellViewModel {
//    var cells = ["2"]
//    var cellImage :[UIImage?] = [nil]
   
    private var cells = [Cell]()
    weak var delegate:ModelDelegate?
    
    
    func createCell (imageNew: UIImage, textNew: DateFormatter) {
        cells.append(Cell(newImage: imageNew, newDate: textNew))
        delegate?.cellsDidUpdate()
    }
    
    func getDate( for indexPath: IndexPath) -> String  {
        let index = indexPath.row
        return cells[index].date.string(from:  Date())
    }
    
    func getImage( for indexPath: IndexPath) -> UIImage  {
          let index = indexPath.row
          return cells[index].photo
      }
    
    func getCountOfRows() -> Int {
        return cells.count
    }

   
  }


