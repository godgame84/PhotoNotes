//
//  AnnotationsForMap.swift
//  PhotoNotes
//
//  Created by Иван Лебедев on 03.03.2020.
//  Copyright © 2020 Иван Лебедев. All rights reserved.
//

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
