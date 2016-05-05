//
//  GCDMainQueue.swift
//  OnTheMap_P3_iOS_NanoDegree
//
//  Created by Calum Harris on 05/05/2016.
//  Copyright © 2016 Calum Harris. All rights reserved.
//

import Foundation

func performUIUpdatesOnMain(updates: () -> Void) {
  dispatch_async(dispatch_get_main_queue()) {
    updates()
  }
}