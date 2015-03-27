//
//  ViewController.swift
//  Messaging
//
//  Created by Ali Nazzal on 3/14/15.
//  Copyright (c) 2015 Ali Nazzal. All rights reserved.
//

import UIKit
import Parse
import Bolts

class ViewController: UIViewController {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "profileSegue") {
            var dest = segue.destinationViewController as UINavigationController
            var second = dest.topViewController as ProfileController
            second.toPass = usernameField.text
        }
    }

    @IBAction func viewTapped(sender: UITapGestureRecognizer) {
        usernameField.resignFirstResponder()
        passwordField.resignFirstResponder()
    }
    
    @IBAction func logUserIn() {
            PFUser.logInWithUsernameInBackground(self.usernameField.text, password: self.passwordField.text) {
                (user: PFUser!, error: NSError!) -> Void in
                        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                            () -> Void in
                if (user != nil) {
                    dispatch_async(dispatch_get_main_queue()) {
                        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
                        if (appDelegate.client != nil) {
                            appDelegate.client!.stopListeningOnActiveConnection()
                            appDelegate.client!.terminate()
                            appDelegate.client = nil
                        }
                        appDelegate.createSinchClient(user.objectId)
                        self.performSegueWithIdentifier("profileSegue", sender: self)
                    }
                }
                }
            }
//        }
    }
}

