//
//  CellViewModelSecondVC.swift
//  PhotoNotes
//
//  Created by Иван Лебедев on 25.02.2020.
//  Copyright © 2020 Иван Лебедев. All rights reserved.
//

import Foundation
import MapKit

class CellViewModelSecondVC {
    
    var cell: Cell
    var indexPath:IndexPath
    
  init(newDescr: String, newImage: UIImage, newIndexPath:IndexPath, newMapCoordinates:CLLocationCoordinate2D){
    cell = (Cell(newImage: newImage, newDate: "", newAddress: "", newDescript: newDescr, newCoord: newMapCoordinates))
    indexPath=newIndexPath
    }
    
    func getDescription() -> String  {

        return cell.descript
    }

    func getImage() -> UIImage  {
        return cell.photo
      }
    func getIndexPath() -> IndexPath {
 
        return indexPath
    }
     func getMapCoord() -> CLLocationCoordinate2D {
        return cell.MapCoord
       }
}
