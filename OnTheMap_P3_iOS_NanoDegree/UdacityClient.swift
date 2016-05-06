//
//  UdacityClient.swift
//  OnTheMap_P3_iOS_NanoDegree
//
//  Created by Calum Harris on 06/05/2016.
//  Copyright © 2016 Calum Harris. All rights reserved.
//

import Foundation

struct UdacityClient {

  // define completion handler typalias and Result enum for use throughout Authentication.
  
  typealias CompletionHandler = (Result) -> Void

  enum Result {
    case Success(AnyObject?)
    case Failure(ErrorType)
}

  
  func taskForPost(action: String, jsonBody: String, completionHandler: CompletionHandler) -> NSURLSessionDataTask {
    
    let session = NSURLSession.sharedSession()
    
    // Build URL and configure the request
    let request = NSMutableURLRequest(URL: URLFromAction(action))
    request.HTTPMethod = "Post"
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.HTTPBody = jsonBody.dataUsingEncoding(NSUTF8StringEncoding)
    
    // make request
    
    let task = session.dataTaskWithRequest(request) {(data, response, error) in
      
      // GUARD: Was there an error
      
      
    
    
    
  }

  private func URLFromAction(action: String, additionalParameter: String? = nil) -> NSURL {
    
    let components = NSURLComponents()
    components.scheme = UdacityConstants.APIScheme
    components.host = UdacityConstants.APIHost
    components.path = UdacityConstants.APIPath
    components.query = action + "/" + (additionalParameter ?? "")
    
    return components.URL!
    
  }

  
  
}

  