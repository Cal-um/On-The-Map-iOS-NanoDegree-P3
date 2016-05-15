//
//  LoginViewController.swift
//  OnTheMap_P3_iOS_NanoDegree
//
//  Created by Calum Harris on 29/04/2016.
//  Copyright © 2016 Calum Harris. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
  
  // MARK: Life cycle and properties
  
  
  var userData: UserModel?
  
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  
  @IBOutlet weak var loginButton: UIButton!
  @IBOutlet weak var signUpButton: UIButton!
  
  @IBOutlet weak var loadingWheel: UIActivityIndicatorView!
  
  override func viewDidLoad() {
    emailTextField.delegate = self
    passwordTextField.delegate = self
  }
  
  
  
  // Actions
  
  @IBAction func loginButtonPressed(sender: AnyObject) {
  
    guard let email = emailTextField.text, password = passwordTextField.text where email != "" && password != "" else {
      loginErrorAlert("Empty Field")
      return
    }
    
    enableUI(false)
    
    UdacityClient().authenticateWithLoginAndReturnUserModel(email, password: password) { LoginResult in
      
     
      performUIUpdatesOnMain {
      
        switch LoginResult {
          
        case let .Success(result):
            self.userData = result
            self.enableUI(true)
            self.performSegueWithIdentifier("loginSuccess", sender: nil)
        
        case let .Failure(error):
          self.enableUI(true)
          let errorMessage = error as NSError
          print(errorMessage.localizedDescription)
          self.loginErrorAlert(errorMessage.localizedDescription)
        }
      }
    }
  }
  
    

  
  @IBAction func signUpButtonPressed(sender: AnyObject) {
    
    if let url = NSURL(string: UdacityConstants.UdacitySignUpURL) {
      
      UIApplication.sharedApplication().openURL(url)
    }
  }
  
  
  func loginErrorAlert(message: String) {
    var alertMessage = ""
    
    switch message {
    case "No Internet Connection": alertMessage = "No Internet Connection"
    case "Invalid Login Details": alertMessage = "Incorrect Login Details"
    case "Empty Field": alertMessage = "Please Enter Userame and Password"
    default: alertMessage = "Something Went Wrong During Login, Please Try Again"
    }
    
    let ac = UIAlertController(title: "Error", message: alertMessage, preferredStyle: .Alert)
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
  
  
  
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    if textField == emailTextField {
      passwordTextField.becomeFirstResponder()
    } else {
      passwordTextField.resignFirstResponder()
    }
    return true
  }
  
  
  
  func enableUI(isOn: Bool) {
    
    emailTextField.enabled = isOn
    passwordTextField.enabled = isOn
    loginButton.enabled = isOn
    signUpButton.enabled = isOn
    
    if isOn {
      loadingWheel.stopAnimating()
      
    } else {
      loadingWheel.startAnimating()
    }
    
  }
  
  
  
}
