//
//  CellViewModelSecondVC.swift
//  PhotoNotes
//
//  Created by Иван Лебедев on 25.02.2020.
//  Copyright © 2020 Иван Лебедев. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class AnnotationForMap: NSObject, MKAnnotation {
  var coordinate: CLLocationCoordinate2D
  var title: String?
  var subtitle: String?
  
  init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String) {
    self.coordinate = coordinate
    self.title = title
    self.subtitle = subtitle
  }
}

class CellViewModelSecondVC {
    
    let cell: Cell
    let indexPath:IndexPath
    let annotation:AnnotationForMap
    
    
   
    
    init(newDescr: String, newImage: UIImage, newIndexPath:IndexPath, newMapCoordinates:CLLocationCoordinate2D, newAddr:String){
    cell = (Cell(newImage: newImage, newDate: "", newAddress: newAddr, newDescript: newDescr, newLatitude: newMapCoordinates.latitude, newLongitude: newMapCoordinates.longitude))
    indexPath=newIndexPath
         annotation = AnnotationForMap(coordinate: CLLocationCoordinate2D(latitude: cell.MapCoord.latitude, longitude: cell.MapCoord.longitude), title: cell.address, subtitle: cell.address)
    }
    
    var getAnnotation: AnnotationForMap{
        return annotation
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
    var getAddress: String{
        return cell.address
    }
    
}
