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
    
    @IBAction func signUp(sender: AnyObject) {
        if username.text == "" || password == "" {
            let alert = UIAlertController(title: "Form Error", message: "Please enter a username and password.", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
                self.dismissViewControllerAnimated(true, completion: nil)
            }))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func signIn(sender: AnyObject) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

