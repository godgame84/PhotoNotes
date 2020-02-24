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

import UIKit
import Foundation
import CoreLocation

class CellViewModel {
    private var cells = [Cell]()
    weak var delegate:ModelDelegate?
    
    
    func createCell (imageNew: UIImage, textNew: String, realAddress:String, realDescript:String) {
    
        cells.append(Cell(newImage: imageNew, newDate: textNew, newAddress: realAddress,newDescript: realDescript))
        delegate?.cellsDidUpdate()
    }
    
    func updateDescript(newDescription:String) {
        
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
     func getDescript(for indexPath: IndexPath) -> String {
           let index = indexPath.row
           return cells[index].descript
       }
    
    func getCountOfRows() -> Int {
        return cells.count
    }

   
  }


