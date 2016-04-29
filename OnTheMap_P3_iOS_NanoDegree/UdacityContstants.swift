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
  
  struct parameterKeys {
    
    static let username = "username"
    static let password = "password"
  }
  
}