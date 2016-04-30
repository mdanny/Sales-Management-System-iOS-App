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
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var responseContainer: NSHTTPURLResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func loginButtonTapped(sender: UIButton) {
        
        let email = self.emailTextField.text!
        let password = self.passwordTextField.text!
        
        Alamofire.request(.POST, "http://46.101.104.55:3000/login", parameters: ["email" : email, "password": password]).responseJSON {
            response in

            if let JSON = response.response {
                self.responseContainer = JSON
                print("RESPONSE OBJECT: \n")
                print(self.responseContainer)
                print("URL:\n")
                print(self.responseContainer!.URL!)
            
                if String(self.responseContainer!.URL!) == "http://46.101.104.55:3000/profile" {
                    print("Authentication validated!")
                    self.performSegueWithIdentifier("ShowViewSegue", sender: self)
                }
                else {
                    print("Authentication failed!")
                }
            }
        }
        
    }

}
