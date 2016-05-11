//
//  LoginViewController.swift
//  OnTheMap_P3_iOS_NanoDegree
//
//  Created by Calum Harris on 29/04/2016.
//  Copyright © 2016 Calum Harris. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
  
  // MARK: Life cycle and properties
  
  
  var userData: UserModel?
  
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  
  @IBOutlet weak var loginButton: UIButton!
  @IBOutlet weak var signUpButton: UIButton!
  
  
  
  
  @IBAction func loginButtonPressed(sender: AnyObject) {
  
    
    
   
    
    
    guard let email = emailTextField.text, password = passwordTextField.text where email != "" && password != "" else {
      errorInTextfield()
      return
    }
    print("got this far")
    
    UdacityClient().authenticateWithLoginAndReturnUserModel(email, password: password) { LoginResult in
      performUIUpdatesOnMain {
      
        switch LoginResult {
          
        case let .Success(result):
            print(result.userKey)
            print(result.firstName)
            print(result.lastName)
            self.userData = result
            self.performSegueWithIdentifier("loginSuccess", sender: nil)
        
        case let .Failure(error):
          print(error)
        }
      }
    }
  }
  
    

  
  @IBAction func signUpButtonPressed(sender: AnyObject) {
    
    if let url = NSURL(string: UdacityConstants.UdacitySignUpURL) {
      
      UIApplication.sharedApplication().openURL(url)
    }
  }
  
  
  func errorInTextfield() {
    
    let ac = UIAlertController(title: "Error", message: "Please enter Username and Password", preferredStyle: .Alert)
    ac.addAction(UIAlertAction(title: "OK'", style: .Default, handler: nil))
    presentViewController(ac, animated: true, completion: nil)
    
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "loginSuccess" {
      let tabBarController = segue.destinationViewController as! UITabBarController
      let destinationTabBarController = tabBarController as! MapAndListTabBarController
      
      if let userData = userData {
        destinationTabBarController.userData = userData
      }
    }
  }
  
  
  
}
