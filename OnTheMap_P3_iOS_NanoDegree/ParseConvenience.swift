//
//  ParseConvenience.swift
//  OnTheMap_P3_iOS_NanoDegree
//
//  Created by Calum Harris on 13/05/2016.
//  Copyright © 2016 Calum Harris. All rights reserved.
//

import Foundation

extension ParseClient {
  
  typealias completionHandlerFor100Students = (DictionaryResult) -> Void
  
  enum DictionaryResult {
    case Success([[String : AnyObject]])
    case Failure(ErrorType)
    
  }
  
  
  func get100StudentProfiles(get100StudentProfilesCompletionHandler: (DictionaryResult) -> Void) {
    
    let parameters: [String : AnyObject] = [ParseConstants.ParamenterKeys.Limit : ParseConstants.ParameterValues.Limit, ParseConstants.ParamenterKeys.OrderBy : ParseConstants.ParameterValues.OrderBy]
  
    taskForGet(parameters) { (result) -> Void in
      
      switch result {
      case let .Success(results):
        
        guard let records = results![ParseConstants.JsonResponseKeys.Results] as? [[String:AnyObject]] else {
          let userInfo = [NSLocalizedDescriptionKey : "Cannot find key '\(ParseConstants.JsonResponseKeys.Results)' in \(results)"]
          get100StudentProfilesCompletionHandler(.Failure(NSError(domain: "taskForGetSwitchResults", code: 1, userInfo: userInfo)))
          return
        }
        
        get100StudentProfilesCompletionHandler(.Success(records))
        
      case let .Failure(error):
        get100StudentProfilesCompletionHandler(.Failure(error))
      }
    }
  }
}