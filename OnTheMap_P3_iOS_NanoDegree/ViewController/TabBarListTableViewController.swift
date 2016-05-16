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
  
  var studentDataModel: [StudentInformation] {
    return (UIApplication.sharedApplication().delegate as! AppDelegate).studentCollection
  }
  
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
  
  
  @IBAction func refreshDataButtonPressed(sender: AnyObject) {
    refreshData()
  }
  
  
  // MARK: Networking methods
  
  func refreshData() {
    
    ParseClient().get100StudentProfiles { profiles -> Void in
      
      switch profiles {
        
      case let .Success(passToAppDelegate):
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.studentCollection = StudentInformation.getStudentsInfoFromResults(passToAppDelegate)
        print(appDelegate.studentCollection)
        
        performUIUpdatesOnMain {
          self.tableView.reloadData()
        }
        
      case let .Failure(error):
        print(error)
      }
    }
  }
}


extension TabBarListTableViewController {
  
  // MARK: Table View methods
  
  
  
  
}
