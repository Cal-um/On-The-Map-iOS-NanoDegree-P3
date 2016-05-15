//
//  StudentInformation.swift
//  OnTheMap_P3_iOS_NanoDegree
//
//  Created by Calum Harris on 14/05/2016.
//  Copyright © 2016 Calum Harris. All rights reserved.
//

import Foundation

struct StudentInformation {
  
  var uniqueKey: String
  var firstName: String
  var lastName: String
  var mapString: String
  var mediaURL: String
  var latitude: Double
  var longitude: Double

  init (dictionary: [String : AnyObject]){
    
    uniqueKey = dictionary[ParseConstants.JsonKeys.uniqueKey] as! String
    firstName = dictionary[ParseConstants.JsonKeys.firstName] as! String
    lastName = dictionary[ParseConstants.JsonKeys.lastName] as! String
    mapString = dictionary[ParseConstants.JsonKeys.mapString] as! String
    mediaURL = dictionary[ParseConstants.JsonKeys.mediaURL] as! String
    latitude = dictionary[ParseConstants.JsonKeys.latitude] as! Double
    longitude = dictionary[ParseConstants.JsonKeys.longitude] as! Double
    
  }

}


extension StudentInformation {
  
  static func getStudentsCollectionFromResults(results: [[String : AnyObject]]) -> StudentsCollection {
   
    
    
    
  }
  
    
    
  }
  
  
}