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
    return StudentCollection.sharedInstance.studentCollection
  }
  
  override func viewWillAppear(animated: Bool) {
    
    // checks if there is any data and if not, fetches data (there is no point refreshing every time the page appears)
    
    if studentDataModel.count == 0 {
      refreshData()
    }
    
    tableView.reloadData()
  }
  
  
  // MARK: Actions
  
  @IBAction func openAddLocation(sender: AnyObject) {
    tabBarController!.performSegueWithIdentifier("addLocation", sender: sender)
  }
  
  
  @IBAction func refreshDataButtonPressed(sender: AnyObject) {
    refreshData()
  }
  
  @IBAction func logoutButtonTapped(sender: AnyObject) {
    
    UdacityClient().taskForDelete(UdacityConstants.logout) { (result) -> Void in
      switch result {
        
      case let .Success(json):
        performUIUpdatesOnMain {
        print(json)
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
        
      case let .Success(passToAppSingleton):
        
        StudentCollection.sharedInstance.studentCollection = StudentInformation.getStudentsInfoFromResults(passToAppSingleton)
        print(StudentCollection.sharedInstance.studentCollection)
        
        performUIUpdatesOnMain {
          self.tableView.reloadData()
        }
        
      case let .Failure(error):
        print(error)
        performUIUpdatesOnMain {
          self.networkErrorAlert()
        }
      }
    }
  }
}




extension TabBarListTableViewController {
  
  // MARK: Table View data source
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return studentDataModel.count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
  
    let cell = tableView.dequeueReusableCellWithIdentifier("nameCell")!
    let student = studentDataModel[indexPath.row]
    cell.textLabel?.text = "\(student.firstName) \(student.lastName)"
    cell.imageView?.image = UIImage(named: "pin")
    return cell
  }
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let student = studentDataModel[indexPath.row]
    
    if let url = NSURL(string: student.mediaURL) {
      UIApplication.sharedApplication().openURL(url)
    } else {
      noWebsiteAlert()
    }
  }
  
  // MARK: Alert Controllers
  
  func networkErrorAlert() {
    
    let alertMessage = "There was a network error, try and tap the refresh button"
    let ac = UIAlertController(title: "Whoops", message: alertMessage, preferredStyle: .Alert)
    ac.addAction(UIAlertAction(title: "OK'", style: .Default, handler: nil))
    
    presentViewController(ac, animated: true, completion: nil)
  }
  
  // TODO: This aint working.
  func noWebsiteAlert() {
    
    let alertMessage = "This student did not enter a website"
    let ac = UIAlertController(title: "Whoops", message: alertMessage, preferredStyle: .Alert)
    ac.addAction(UIAlertAction(title: "OK'", style: .Default, handler: nil))
    
    presentViewController(ac, animated: true, completion: nil)
  }
  
  func unsuccessfulLogoutAlert() {
    
    let alertMessage = "Unsuccessful Logout due to network error"
    let ac = UIAlertController(title: "Warning", message: alertMessage, preferredStyle: .Alert)
    ac.addAction(UIAlertAction(title: "OK'", style: .Default, handler: { (UIAlertAction) -> Void in self.dismissViewControllerAnimated(true, completion: nil) }))
    
    presentViewController(ac, animated: true, completion: nil)
  }
}
