//
//  TabBarListViewController.swift
//  OnTheMap_P3_iOS_NanoDegree
//
//  Created by Calum Harris on 29/04/2016.
//  Copyright © 2016 Calum Harris. All rights reserved.
//

import UIKit

class TabBarListTableViewController: UITableViewController {
  
  // MARK: properties and life cycles.
  
  var userData: UserModel!
  
  
  override func viewDidLoad() {
    
    // get the user data from the tab bar controller
   userData = (tabBarController as! MapAndListTabBarController).userData
    
  }
  
  @IBAction func openAddLocation(sender: AnyObject) {
    
    (tabBarController as! MapAndListTabBarController).performSegueWithIdentifier("addLocation", sender: sender)
  }

  
}
