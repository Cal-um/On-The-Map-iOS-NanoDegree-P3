//
//  ParseClient.swift
//  OnTheMap_P3_iOS_NanoDegree
//
//  Created by Calum Harris on 13/05/2016.
//  Copyright © 2016 Calum Harris. All rights reserved.
//

import Foundation

struct ParseClient {
  
  typealias completionHandlerForGet = (Result) -> Void
  
  enum Result {
    case Success(AnyObject?)
    case Failure(ErrorType)
  }
  
  
  func taskForGet(parameters: [String : AnyObject], completionHandler: completionHandlerForGet) -> NSURLSessionDataTask {
  
    let session = NSURLSession.sharedSession()
    
    // Build URL and configure the request
    
    // Build URL and configure the request
    let request = NSMutableURLRequest(URL: createURLFromParameters(parameters))
    request.HTTPMethod = "GET"
    //request.addValue(ParseConstants.HTTPHeaderKeys.ApplicationID, forHTTPHeaderField: ParseConstants.HTTPHeaderValues.ApplicationID)
    //request.addValue(ParseConstants.HTTPHeaderKeys.RESTAPIKey, forHTTPHeaderField: ParseConstants.HTTPHeaderValues.RESTAPIKey)
    request.addValue(ParseConstants.HTTPHeaderValues.ApplicationID, forHTTPHeaderField: ParseConstants.HTTPHeaderKeys.ApplicationID)
    request.addValue(ParseConstants.HTTPHeaderValues.RESTAPIKey, forHTTPHeaderField: ParseConstants.HTTPHeaderKeys.RESTAPIKey)
    print(request.allHTTPHeaderFields)
    // Make request
    
    let task = session.dataTaskWithRequest(request) {(data, response, error) in
      
      func sendError(error: String) {
        print(error)
        let userInfo = [NSLocalizedDescriptionKey: error]
        completionHandler(.Failure(NSError(domain: "taskForGet", code: 1, userInfo: userInfo)))
      }
      
      guard (error == nil) else {
        sendError("There was an error with your request \(error)")
        return
      }
    
      // GUARD: Did we get a successful 2XX response
      guard let statusCode = (response as? NSHTTPURLResponse)?.statusCode where statusCode >= 200 && statusCode <= 299 else {
        sendError("Your request returned a status code other than 2xx \(response)")
        return
      }
      
      // GUARD: Was there any data returned?
      guard let data = data else {
        sendError("No data was returned by your request")
        return
      }
      
      // Parse the data and use the data (Happens in the completion handler)
      self.convertDataWithCompletionHander(data, completionHandlerForConversion: completionHandler)
  
    }
    task.resume()
    return task
  }
  
  
  private func convertDataWithCompletionHander(data: NSData, completionHandlerForConversion: completionHandlerForGet) {
    print(data)
    var parsedResult: AnyObject!
    do {
      
      parsedResult = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
    } catch {
      
      let userInfo = [NSLocalizedDescriptionKey : "Could not parse the data as JSON: '\(data)'"]
      completionHandlerForConversion(.Failure(NSError(domain: "convertDataWithCompletionHander", code: 1, userInfo: userInfo)))
    }
    
    completionHandlerForConversion(.Success(parsedResult))
    
  }
  
  
  private func createURLFromParameters(parameters: [String : AnyObject]) -> NSURL {
    
    let components = NSURLComponents()
    components.scheme = ParseConstants.APIScheme
    components.host = ParseConstants.APIHost
    components.path = ParseConstants.APIPath
    components.queryItems = [NSURLQueryItem]()
    
    for (key, value) in parameters {
      
      let queryItem = NSURLQueryItem(name: key, value: "\(value)")
      components.queryItems?.append(queryItem)
    }
    print(components.URL)
    return components.URL!
  }
  
}