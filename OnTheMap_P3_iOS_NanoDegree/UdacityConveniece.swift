//
//  UdacityConveniece.swift
//  OnTheMap_P3_iOS_NanoDegree
//
//  Created by Calum Harris on 06/05/2016.
//  Copyright © 2016 Calum Harris. All rights reserved.
//

import Foundation

extension UdacityClient {
  
   func loginToUdacity(userName: String, password: String)  {
    
    print("meow")
    
    let jsonBody = "{\"udacity\": {\"username\": \"\(userName)\", \"password\": \"\(password)\"}}"
    
    taskForPost(UdacityConstants.login, jsonBody: jsonBody) { (result) -> Void in
      
      switch (result) {
      case let .Success(data):
      print("meow1")
      print(data)
      case let .Failure(error):
        print("moot")
      print(String(error))
      break
      }
    }
  }
  

  
  
}