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
  
  
  
  
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  
  @IBOutlet weak var loginButton: UIButton!
  @IBOutlet weak var signUpButton: UIButton!
  
  
  
  @IBAction func loginButtonPressed(sender: AnyObject) {
    
    
    
    
    
    
  }
  
  
  @IBAction func signUpButtonPressed(sender: AnyObject) {
    
    UIApplication.sharedApplication().openURL(NSURL(string: "https://www.udacity.com/account/auth#!/signup")!)
    
    
    
  }
  
  
  func errorInTextfield() {
    let ac = UIAlertController(title: "Error", message: "Please enter Username and Password", preferredStyle: .Alert)
    ac.addAction(UIAlertAction(title: "OK'", style: .Default, handler: nil))
    presentViewController(ac, animated: true, completion: nil)
    
  }
  
  
}
