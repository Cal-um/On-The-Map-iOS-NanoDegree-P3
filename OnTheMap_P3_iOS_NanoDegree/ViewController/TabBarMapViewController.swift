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
  
  @IBAction func logoutButtonTapped(sender: AnyObject) {
    
    UdacityClient().taskForDelete(UdacityConstants.logout) { (result) -> Void in
      switch result {
        
      case let .Success(string):
        performUIUpdatesOnMain {
          print(string)
          self.dismissViewControllerAnimated(true, completion: nil)
        }
      case let .Failure(error):
        performUIUpdatesOnMain {
          self.unsuccessfulLogoutAlert()
          print(error)
        }
      }
    }
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
  
  // Alert methods
  
  func unsuccessfulLogoutAlert() {
    
    let alertMessage = "Unsuccessful Logout due to network error"
    let ac = UIAlertController(title: "Warning", message: alertMessage, preferredStyle: .Alert)
    ac.addAction(UIAlertAction(title: "OK'", style: .Default, handler: { (UIAlertAction) -> Void in self.dismissViewControllerAnimated(true, completion: nil) }))
    
    presentViewController(ac, animated: true, completion: nil)
  }
  
  func networkErrorAlert() {
    
    let alertMessage = "There was a network error, try and tap the refresh button"
    let ac = UIAlertController(title: "Whoops", message: alertMessage, preferredStyle: .Alert)
    ac.addAction(UIAlertAction(title: "OK'", style: .Default, handler: nil))
    
    presentViewController(ac, animated: true, completion: nil)
  }
  
  
  
}





