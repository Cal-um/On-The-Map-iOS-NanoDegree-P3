//
//  UdacityClient.swift
//  OnTheMap_P3_iOS_NanoDegree
//
//  Created by Calum Harris on 06/05/2016.
//  Copyright © 2016 Calum Harris. All rights reserved.
//

import Foundation

// Define completion handler typalias and Result enum for use throughout Authentication.

typealias AuthenticationCompletionHandler = (Result) -> Void

enum Result {
  case Success(AnyObject?)
  case Failure(ErrorType)
  
}

struct UdacityClient {


  
  func taskForPost(action: String, jsonBody: String, completionHandler: AuthenticationCompletionHandler) -> NSURLSessionDataTask {
    
    let session = NSURLSession.sharedSession()
    
    // Build URL and configure the request
    let request = NSMutableURLRequest(URL: URLFromAction(action))
    request.HTTPMethod = "Post"
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.HTTPBody = jsonBody.dataUsingEncoding(NSUTF8StringEncoding)
    print("1")
    
    // make request
    
    let task = session.dataTaskWithRequest(request) {(data, response, error) in
      
      func sendError(error: String) {
        print(error)
        let userInfo = [NSLocalizedDescriptionKey : error]
        completionHandler(.Failure(NSError(domain: "taskForPOST", code: 1, userInfo: userInfo)))
      }
print("2")
      
      // GUARD: Was there an error
      guard (error == nil) else {
        sendError("There was an error with your request \(error)")
        return
      }
      
      // GUARD: Did we get a successful 2XX response
      guard let statusCode = (response as? NSHTTPURLResponse)?.statusCode where statusCode >= 200 && statusCode <= 299 else {
        sendError("Your request returned a status code other than 2xx" + String(response))
        return
      }
      
      // GUARD: Was there any data returned?
      guard let data = data else {
        sendError("No data was returned by your request")
        return
      }
      
      // Parse the data and use the data (Happens in the completion handler)
      self.convertDataWithCompletionHander(data, completionHandler: completionHandler)
    
    
    }
    task.resume()
    return task
  }

  private func convertDataWithCompletionHander(data: NSData, completionHandler: AuthenticationCompletionHandler) {
    
    var parsedResult: AnyObject!
    do {
      parsedResult = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
    } catch {
      
      let userInfo = [NSLocalizedDescriptionKey : "Could not parse the data as JSON: '\(data)'"]
      completionHandler(.Failure(NSError(domain: "convertDataWithCompletionHander", code: 1, userInfo: userInfo)))
    }
    
    completionHandler(.Success(parsedResult))
  
  }
  
  private func URLFromAction(action: String, additionalParameter: String? = nil) -> NSURL {
    
    let components = NSURLComponents()
    components.scheme = UdacityConstants.APIScheme
    components.host = UdacityConstants.APIHost
    components.path = UdacityConstants.APIPath + action + "/" + (additionalParameter ?? "")
    print(components.URL!)
    
    return components.URL!
    
  }

  
  
}

  