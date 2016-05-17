//
//  InfoPostingViewController.swift
//  OnTheMap_P3_iOS_NanoDegree
//
//  Created by Calum Harris on 29/04/2016.
//  Copyright © 2016 Calum Harris. All rights reserved.
//

import MapKit
import UIKit

class InfoPostingViewController: UIViewController {
  
  var userData: UserModel!
  
  @IBOutlet weak var whereAreyouStudying1: UILabel!
  @IBOutlet weak var whereAreYouStudying2: UILabel!
  @IBOutlet weak var whereAreYouStudying3: UILabel!
  @IBOutlet weak var mapView: MKMapView!
  
  @IBOutlet weak var cancelBarButton: UIBarButtonItem!
  
  @IBOutlet weak var webAddressTextField: UITextField!
  @IBOutlet weak var locationTextField: UITextField!
  
  @IBOutlet weak var submitButton: UIButton!
  @IBOutlet weak var findOnMapButton: UIButton!
  
  @IBAction func goBackAction(sender: AnyObject) {
    
    dismissViewControllerAnimated(true, completion: nil)
    
  }
  
  
  
  
  
}
