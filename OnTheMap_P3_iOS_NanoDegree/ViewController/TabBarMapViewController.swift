//
//  TabBarMapViewController.swift
//  OnTheMap_P3_iOS_NanoDegree
//
//  Created by Calum Harris on 29/04/2016.
//  Copyright © 2016 Calum Harris. All rights reserved.
//

import UIKit
import MapKit


class TabBarMapViewController: UIViewController {
  
  // MARK: Properties and outlets
  
  @IBOutlet weak var mapView: MKMapView!
  
  var userData: UserModel!
  
  // MARK: View Cycles
  
  override func viewDidLoad() {
    
    // get the user data from the tab bar controller
    let tbvc = self.tabBarController  as! MapAndListTabBarController
    userData = tbvc.userData!
    
  }
  
  
  
  
}
