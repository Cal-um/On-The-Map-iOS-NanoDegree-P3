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
  
  var studentDataModel: [StudentInformation] {
    return (UIApplication.sharedApplication().delegate as! AppDelegate).studentCollection
  }
  
  
  // MARK: View Cycles
  
  override func viewWillAppear(animated: Bool) {
    
    // checks if there is any data and if not, fetches data (there is no point refreshing every time the page appears)
    
    if studentDataModel.count == 0 {
      refreshData()
    }
    
  }
  
  // MARK: Actions
  
  @IBAction func openAddLocation(sender: AnyObject) {
    
    (tabBarController as! MapAndListTabBarController).performSegueWithIdentifier("addLocation", sender: sender)
    
  }
  
  @IBAction func refreshButtonPress(sender: AnyObject) {
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    print(appDelegate.studentCollection)
    
  }
  
  
  // MARK: Networking methods
  
  func refreshData() {
    
    ParseClient().get100StudentProfiles { profiles -> Void in
      
      switch profiles {
        
      case let .Success(passToAppDelegate):
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.studentCollection = StudentInformation.getStudentsInfoFromResults(passToAppDelegate)
        print(appDelegate.studentCollection)

        
      case let .Failure(error):
        print(error)
      }
    }
  }
}



