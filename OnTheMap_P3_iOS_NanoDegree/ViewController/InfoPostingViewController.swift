//
//  InfoPostingViewController.swift
//  OnTheMap_P3_iOS_NanoDegree
//
//  Created by Calum Harris on 29/04/2016.
//  Copyright © 2016 Calum Harris. All rights reserved.
//

import MapKit
import UIKit
import CoreLocation

class InfoPostingViewController: UIViewController {
  
  // MARK: Properties and outlets
  
  // userData contains the name and ID of the user
  
  var userData: UserModel! {
    return (UIApplication.sharedApplication().delegate as! AppDelegate).userModel  }
  
  var coordinates: CLLocationCoordinate2D?
  var mapString: String?
  
  @IBOutlet weak var whereAreyouStudying1: UILabel!
  @IBOutlet weak var whereAreYouStudying2: UILabel!
  @IBOutlet weak var whereAreYouStudying3: UILabel!
  @IBOutlet weak var mapView: MKMapView!
  
  @IBOutlet weak var cancelBarButton: UIBarButtonItem!
  
  @IBOutlet weak var webAddressTextField: UITextField!
  @IBOutlet weak var locationTextField: UITextField!
  
  @IBOutlet weak var submitButton: UIButton!
  @IBOutlet weak var findOnMapButton: UIButton!
  
  @IBOutlet weak var activityViewOutlet: UIActivityIndicatorView!
  
  // MARK: Actions
  
  @IBAction func goBackAction(sender: AnyObject) {
    
    dismissViewControllerAnimated(true, completion: nil)
    
  }
  
  @IBAction func FindOnMapButtonTapped(sender: AnyObject) {
    
    if let locationString = locationTextField.text where locationTextField.text != "" {
      
      let geoCoder = CLGeocoder()
      
      // activity wheel begins when geocoding
      activityViewOutlet.startAnimating()
      locationTextField.enabled = false
     
      geoCoder.geocodeAddressString(locationString, completionHandler: {(placemarks: [CLPlacemark]?, error: NSError?) in
        
        guard (error == nil) else {
          print("Geocode failed with error: \(error?.localizedDescription)")
          self.customMessageAlert("There was an error fetching your location")
          self.activityViewOutlet.stopAnimating()
          self.locationTextField.enabled = true
          return
        }
        
        guard let fetchedLocations = placemarks else {
          self.customMessageAlert("Location not found")
          self.activityViewOutlet.stopAnimating()
          self.locationTextField.enabled = true
          return
        }
        
        self.activityViewOutlet.stopAnimating()
        self.locationTextField.enabled = true
        let firstResult = fetchedLocations.first
        let location = firstResult?.location
        self.coordinates = location?.coordinate
        self.mapString = locationString
        self.setLayoutForType(.AddLink)
        self.addPinFromCoordinates(self.coordinates!)
        
        
      })
  
    
    } else {
      customMessageAlert("Please enter your location")
    }
  }

  @IBAction func submitButtonPressed(sender: AnyObject) {
    
    if let webString = webAddressTextField.text where webAddressTextField.text != nil {
      
      let firstName = userData.firstName
      let lastName = userData.lastName
      let uniqueKey = userData.userKey
      let mString = mapString!
      let lat = coordinates?.latitude
      let long = coordinates?.longitude
      
      
      ParseClient().postStudentLocationToParse(firstName, lastName: lastName, uniqueKey: uniqueKey, mapString: mString, mediaURL: webString, lat: lat!, long: long!) { (result) -> Void in
        
        switch result {
        case let .Success(json):
          print(json)
          
          // ensure student collection is empty so map and table refresh new data.
          
          let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
          appDelegate.studentCollection = []
          performUIUpdatesOnMain({ 
            self.dismissViewControllerAnimated(true, completion: nil)
          })
          
        case let .Failure(error):
          print(error)
          performUIUpdatesOnMain {
            self.customMessageAlert("Unable to update location on server")
          }
        }
      
      }

    } else {
      customMessageAlert("Please enter web address")
    }
    
    
  }
  
  
  
  // MARK: Life Cycles
  
  override func viewWillAppear(animated: Bool) {
    
    setLayoutForType(.AddLocation)
    print(userData)
  }
  
  
  // MARK: Map methods
  
  func addPinFromCoordinates(coordinates: CLLocationCoordinate2D) {
    
    let annotation = MKPointAnnotation()
    annotation.coordinate = coordinates

    let annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pin")
    annotationView.animatesDrop = true
    
    mapView.centerCoordinate = annotation.coordinate
    mapView.addAnnotation(annotationView.annotation!)
    
  }
  
  
  
  
  // MARK: Layout Type and function
  
  enum LayoutType {
    case AddLocation
    case AddLink
    
  }
  
  func setLayoutForType(type: LayoutType) {
    
    switch type {
      
    case .AddLocation:
      
      whereAreyouStudying1.hidden = false
      whereAreYouStudying2.hidden = false
      whereAreYouStudying3.hidden = false
      locationTextField.hidden = false
      findOnMapButton.hidden = false
      
      mapView.hidden = true
      webAddressTextField.hidden = true
      submitButton.hidden = true
      
    case .AddLink:
      
      whereAreyouStudying1.hidden = true
      whereAreYouStudying2.hidden = true
      whereAreYouStudying3.hidden = true
      locationTextField.hidden = true
      findOnMapButton.hidden = true
      
      mapView.hidden = false
      webAddressTextField.hidden = false
      submitButton.hidden = false
      
    }
  }
  
  // Mark: UIAlerts
  
  func customMessageAlert(message: String) {
    
    let ac = UIAlertController(title: "Whoops", message: message, preferredStyle: .Alert)
    ac.addAction(UIAlertAction(title: "OK'", style: .Default, handler: nil))
    presentViewController(ac, animated: true, completion: nil)
  }
  
}
