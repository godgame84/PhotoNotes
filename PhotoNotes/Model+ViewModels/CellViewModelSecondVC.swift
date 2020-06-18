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

    private var fabric = CoreDataStackFactory()
    let indexPath:IndexPath

    
    
   
    
    init(newDescr: String, newImage: UIImage, newIndexPath:IndexPath, newMapCoordinates:CLLocationCoordinate2D, newAddr:String){
    indexPath=newIndexPath
        
    }
    
    var getAnnotation: AnnotationForMap{
        let annotation = AnnotationForMap(coordinate: self.getMapCoord, title: self.getAddress, subtitle: self.getAddress)
        return annotation
    }
    
    var getDescription: String  {
         return fabric.stackOnTarget().getDataFromContext()[indexPath.row].value(forKeyPath: "descr") as! String
    }

    var getImage: UIImage  {
         return UIImage(data: fabric.stackOnTarget().getDataFromContext()[indexPath.row].value(forKeyPath: "photo") as! Data)!
      }
    var getIndexPath: IndexPath {
        return indexPath
    }
    var getMapCoord: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude:  fabric.stackOnTarget().getDataFromContext()[indexPath.row].value(forKeyPath: "latitude") as! Double, longitude:  fabric.stackOnTarget().getDataFromContext()[indexPath.row].value(forKeyPath: "longitude") as! Double)
       }
    var getAddress: String{
       return fabric.stackOnTarget().getDataFromContext()[indexPath.row].value(forKeyPath: "address") as! String
    }
    
}
