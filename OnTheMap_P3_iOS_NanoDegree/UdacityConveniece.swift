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
    
    let jsonBody = "{\"udacity\": {\"username\": \"\(userName)\", \"password\": \"\(password)\"}}"
    
    taskForPost(UdacityConstants.login, jsonBody: jsonBody) { (result) -> Void in
    
      switch result {
      case let .Success(results):
        
        self.getUserKeyAndReturnUserModel(.Success(results)) { (outputOfUserKeyModel) -> Void in
          switch outputOfUserKeyModel {
            
          case let .Success(userModelWithUserKey):
            print(userModelWithUserKey.userKey)
            
            self.taskForGet(UdacityConstants.loginGetUserData, additionalParameter: "/\(userModelWithUserKey.userKey)") { (outputOfTaskForGet) -> Void in
              
              self.returnUserModelFullyPopulated(userModelWithUserKey, jsonData: outputOfTaskForGet) { (outputOfReturnUserModel) -> Void in
                
                switch outputOfReturnUserModel {
                case let .Success(fullyPopulatedUserModel):
                  completionHandlerForAuthenticateWithLogin(.Success(fullyPopulatedUserModel))
                  
                case let .Failure(error):
                  completionHandlerForAuthenticateWithLogin(.Failure(error))
                }
              }
            }
          case let .Failure(error):
            completionHandlerForAuthenticateWithLogin(.Failure(error))
          }
        }
      case let .Failure(error):
        completionHandlerForAuthenticateWithLogin(.Failure(error))
      }
    }
  }
}