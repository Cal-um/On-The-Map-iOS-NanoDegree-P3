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

  static let UdacitySignUpURL = "https://www.udacity.com/account/auth#!/signup"
  
  // URLActions
  static let login = "/session"
  static let logout = "/session"
  static let loginGetUserData = "/users"

  struct HTTPHeaderKeys {
    
    static let AddValueJson = "application/json"
  }
  
  
  struct HTTPHeaderValues {
    
    static let Accept = "Accept"
    static let ContentType = "Content-Type"
    
    
}
  
  struct ParameterKeys {
    
    static let Username = "username"
    static let Password = "password"
  }
  
  struct JSONResponseKeys {
    
    static let AccountDetail = "account"
    static let UserKey = "key"
    static let FirstName = "first_name"
    static let LastName = "last_name"
    static let UserDetails = "user"
    
    
  }
  
}