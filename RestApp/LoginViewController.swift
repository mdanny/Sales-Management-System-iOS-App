//
//  LoginViewController.swift
//  RestApp
//
//  Created by Macrinici Dan on 4/23/16.
//  Copyright © 2016 Daniel Macrinici. All rights reserved.
//

import UIKit
import Alamofire


class LoginViewController: UIViewController {
    
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var loginButtonLabel: UIButton!
    
    @IBOutlet weak var registerButtonLabel: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var responseContainer: NSHTTPURLResponse?
    var accountData: AnyObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        displayWalkthroughs()
    }
    
    func displayWalkthroughs() {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let displayedWalkthrough = userDefaults.boolForKey("DisplayedWalkthrough")
        
        if !displayedWalkthrough {
            if let pageViewController = storyboard?.instantiateViewControllerWithIdentifier("PageViewController") {
                self.presentViewController(pageViewController, animated: true, completion: nil)
            }
        }
        
    }
    
    @IBAction func registerButtonTapped(sender: AnyObject) {
        self.performSegueWithIdentifier("ShowRegisterViewSegue", sender: self)
    }
    
    
    @IBAction func loginButtonTapped(sender: UIButton) {
        
        let email = self.emailTextField.text!
        let password = self.passwordTextField.text!
        
        Alamofire.request(.POST, "http://46.101.104.55:3000/login_ios", parameters: ["email" : email, "password": password]).responseJSON {
            response in

            if let JSON = response.response {
                self.responseContainer = JSON
                print("RESPONSE OBJECT: \n")
                print(self.responseContainer)
                print("URL:\n")
                print(self.responseContainer!.URL!)
                print("This is the URL response value",response.result.value)
                if let result = response.result.value {
                    self.accountData = result
                    print(self.accountData!["profile"]!!["name"])
                    print(self.accountData!["profile"]!!["picture"])
                    //                print("This is the URL response value",response.result.description)
                    
                    if String(self.responseContainer!.URL!) == "http://46.101.104.55:3000/profile_ios" {
                        print("Authentication validated!")
                        self.performSegueWithIdentifier("ShowProfileViewSegue", sender: self)
                    }
                    else {
                        print("Authentication failed!")
                    }
                }
            }
        }
        
    }
    
    //pass accountData associated with a particular user to the profile VC in an objectx
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowProfileViewSegue" {
            let nav = segue.destinationViewController as! UINavigationController
            let pvc = nav.topViewController as! ProfileViewController
            
            pvc.user = self.accountData!
        }
        
//        if segue.identifier == "ShowRegisterViewSegue" {
//            let alertControllerRegister = UIAlertController(title: "Redirecting to registration page", message:"Complete the steps to create an account" , preferredStyle: .ActionSheet)
//            alertControllerRegister.addAction(UIAlertAction(title: "Continue", style: .Default, handler: self))
//            presentViewController(alertControllerRegister, animated: true, completion: nil)
//        }
    }

}
