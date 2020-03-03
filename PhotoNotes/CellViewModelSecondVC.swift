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
    
    let cell: Cell
    let indexPath:IndexPath
    
  init(newDescr: String, newImage: UIImage, newIndexPath:IndexPath, newMapCoordinates:CLLocationCoordinate2D){
    cell = (Cell(newImage: newImage, newDate: "", newAddress: "", newDescript: newDescr, newLatitude: newMapCoordinates.latitude, newLongitude: newMapCoordinates.longitude))
    indexPath=newIndexPath
    }
    
    var getDescription: String  {
        return cell.descript
    }

    var getImage: UIImage  {
        return cell.photo
      }
    var getIndexPath: IndexPath {
        return indexPath
    }
    var getMapCoord: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: cell.MapCoord.latitude, longitude: cell.MapCoord.longitude)
       }
}
