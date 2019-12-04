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


protocol ModelProtocol: class {
    var cells: String { get set }
}

import Foundation

class Model {
    var cells = ["2"]
    
    
  //  var cells = [Cell]()
    weak var delegate:ModelDelegate?
    
    func createCell () {
        cells.append("asdfd")
        delegate?.cellsDidUpdate()
    }
    
    func getCountOfRows() -> Int {
        return cells.count
    }

    
   
  }



