//
//  MapMethods.swift
//  OnTheMap_P3_iOS_NanoDegree
//
//  Created by Calum Harris on 17/05/2016.
//  Copyright © 2016 Calum Harris. All rights reserved.
//

import Foundation
import MapKit

struct MapMethods {
  
  static func getPointAnnotationsFromStudentInformation(array: [StudentInformation]) -> [MKPointAnnotation] {
    
    let annotations: [MKPointAnnotation] = array.map { i in
     
      let lat = CLLocationDegrees(i.latitude)
      let long = CLLocationDegrees(i.longitude)
      let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
      
      let annotation = MKPointAnnotation()
      annotation.coordinate = coordinate
      annotation.title = "\(i.firstName) \(i.lastName)"
      annotation.subtitle = i.mediaURL
      return annotation
    }
    
    return annotations
  }
  
  
}