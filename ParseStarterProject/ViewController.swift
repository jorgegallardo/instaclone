//
//  ViewController.swift
//
//  Copyright 2011-present Parse Inc. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    var errorMessage = "Please try again later."
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var registeredText: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    var signUpActive = true
    
    func displayAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBAction func signUp(sender: AnyObject) {
        if username.text == "" || password == "" {
            displayAlert("Form Error", message: "Please enter a username and password.")
        } else {
            activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
            view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            UIApplication.sharedApplication().beginIgnoringInteractionEvents()
            
            if signUpActive == true {
                let user = PFUser()
                user.username = username.text
                user.password = password.text
                user.signUpInBackgroundWithBlock({ (success, error) -> Void in
                    self.activityIndicator.stopAnimating()
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                    
                    if error == nil {
                        // signup successful
                    } else {
                        if let errorString = error!.userInfo["error"] as? String {
                            self.errorMessage = errorString
                        }
                        self.displayAlert("Failed signup.", message: self.errorMessage)
                    }
                })
            } else {
                PFUser.logInWithUsernameInBackground(username.text!, password: password.text!, block: { (user, error) -> Void in
                    self.activityIndicator.stopAnimating()
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                    
                    if user != nil {
                        // log in successful
                        self.performSegueWithIdentifier("login", sender: self)
                    } else {
                        if let errorString = error!.userInfo["error"] as? String {
                            self.errorMessage = errorString
                        }
                        self.displayAlert("Failed Login.", message: self.errorMessage)
                    }
                })
            }
        }
    }
    
    @IBAction func signIn(sender: AnyObject) {
        if signUpActive == true {
            signupButton.setTitle("Log In", forState: UIControlState.Normal)
            registeredText.text = "Not registered?"
            loginButton.setTitle("Sign Up", forState: UIControlState.Normal)
            signUpActive = false
        } else {
            signupButton.setTitle("Sign Up", forState: UIControlState.Normal)
            registeredText.text = "Already registered?"
            loginButton.setTitle("Login", forState: UIControlState.Normal)
            signUpActive = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        if PFUser.currentUser() != nil {
            self.performSegueWithIdentifier("login", sender: self)
        }
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

