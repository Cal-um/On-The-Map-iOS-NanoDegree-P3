//
//  StudentCollection.swift
//  OnTheMap_P3_iOS_NanoDegree
//
//  Created by Calum Harris on 18/05/2016.
//  Copyright © 2016 Calum Harris. All rights reserved.
//

import Foundation

class StudentCollection {
  
  static let sharedInstance = StudentCollection()
  var studentCollection = [StudentInformation]()
}