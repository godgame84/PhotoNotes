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
import CoreLocation

class CellViewModel {
    private var cells = [Cell]()
    weak var delegate:ModelDelegate?
    
    
    func createCell (imageNew: UIImage, textNew: String, realAddress:String) {
    
        cells.append(Cell(newImage: imageNew, newDate: textNew, newAddress: realAddress))
        delegate?.cellsDidUpdate()
    }
    
    func getDate( for indexPath: IndexPath) -> String  {
        let index = indexPath.row
        return cells[index].date.description
    }
    
    func getImage( for indexPath: IndexPath) -> UIImage  {
          let index = indexPath.row
          return cells[index].photo
      }
    func getAddress(for indexPath: IndexPath) -> String {
        let index = indexPath.row
        return cells[index].address
    }
    
    func getCountOfRows() -> Int {
        return cells.count
    }

   
  }


