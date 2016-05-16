//
//  ParseConstants.swift
//  OnTheMap_P3_iOS_NanoDegree
//
//  Created by Calum Harris on 13/05/2016.
//  Copyright © 2016 Calum Harris. All rights reserved.
//

import Foundation


struct ParseConstants {
  
  static let APIScheme = "https"
  static let APIHost = "api.parse.com"
  static let APIPath = "/1/classes/StudentLocation"
  
  struct HTTPHeaderKeys {
    static let ApplicationID = "X-Parse-Application-Id"
    static let RESTAPIKey = "X-Parse-REST-API-Key"
  }
  
  struct HTTPHeaderValues {
    static let ApplicationID = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
    static let RESTAPIKey = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
  }

  struct ParamenterKeys {
    
    static let Limit = "limit"
    static let OrderBy = "order"
  }
  
  struct ParameterValues {
    
    static let Limit = 100
    static let OrderBy = "-updatedAt"
  }
  
  struct JsonKeys {
    
    static let uniqueKey = "uniqueKey"
    static let firstName = "firstName"
    static let lastName = "lastName"
    static let mapString = "mapString"
    static var mediaURL = "mediaURL"
    static var latitude = "latitude"
    static var longitude = "longitude"
  }
  
  
  struct JsonResponseKeys {
    static let Results = "results"
  }
}


