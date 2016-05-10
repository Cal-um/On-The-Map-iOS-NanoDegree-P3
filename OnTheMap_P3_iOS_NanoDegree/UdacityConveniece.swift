//
//  UdacityConveniece.swift
//  OnTheMap_P3_iOS_NanoDegree
//
//  Created by Calum Harris on 06/05/2016.
//  Copyright © 2016 Calum Harris. All rights reserved.
//

import Foundation

extension UdacityClient {
  
  func authenticateWithLoginAndReturnUserModel(userName: String, password: String, completionHandlerForAuthenticateWithLogin: CompletionHandlerForLogin)  {
    
    print("meow")
    
    let jsonBody = "{\"udacity\": {\"username\": \"\(userName)\", \"password\": \"\(password)\"}}"
    
    taskForPost(UdacityConstants.login, jsonBody: jsonBody) { (result) -> Void in
    
      switch result {
      case let .Success(results):
        self.getUserKeyAndReturnUserModel(.Success(results)) { (userKey) -> Void in
        
          completionHandlerForAuthenticateWithLogin(userKey)
      
        }
      case .Failure:
      break
        
      }
      
    }
    
    
    
    
  }
  
  
}