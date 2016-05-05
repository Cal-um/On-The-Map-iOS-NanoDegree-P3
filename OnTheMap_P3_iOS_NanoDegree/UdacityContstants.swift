//
//  UdacityContstants.swift
//  OnTheMap_P3_iOS_NanoDegree
//
//  Created by Calum Harris on 29/04/2016.
//  Copyright © 2016 Calum Harris. All rights reserved.
//

import Foundation

struct UdacityConstants {
  
  // URL's
  static let APIScheme = "https"
  static let APIHost = "www.udacity.com"
  static let APIPath = "/api"
  
  struct Methods {
    
    static let StartSession = "/session"
    static let Post = "POST"
    static let delete = "DELETE"
    static let addValueJson = "application/json"
    
  }
  
  struct ParameterKeys {
    
    static let Username = "username"
    static let Password = "password"
  }
  
  struct JSONResponseKeys {
    
    static let UserID = "key"
    static let firstName = "first_name"
    static let lastName = "last_name"
    
  }
  
}