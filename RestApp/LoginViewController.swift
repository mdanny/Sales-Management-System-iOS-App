//
//  LoginViewController.swift
//  RestApp
//
//  Created by Macrinici Dan on 4/23/16.
//  Copyright © 2016 Daniel Macrinici. All rights reserved.
//

import UIKit


class LoginViewController: UIViewController {
    
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var loginButtonLabel: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var hashedPassword: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func generateSalt() -> String {
        
        // Testing default value
        let rounds: Int? = 10
        
        var salt: String
        if rounds != nil && rounds >= 4 && rounds <= 31 {
            salt = JKBCrypt.generateSaltWithNumberOfRounds(UInt(rounds!))
        }
        else {
            salt = JKBCrypt.generateSalt()
        }
        
        return salt
    }
    
    
    
    @IBAction func loginButtonTapped(sender: UIButton) {
        
        let email = self.emailTextField.text!
        let password = self.passwordTextField.text!
        
        if let hash = JKBCrypt.hashPassword(password, withSalt: self.generateSalt()) {
            self.hashedPassword = hash
        }
        else {
            hashedPassword = "Hash generation failed!"
        }
        print("Hash password is: \(self.hashedPassword)")
        
        
        if let compare = JKBCrypt.verifyPassword(password, matchesHash: "$2a$10$v3JwCV1jdLrE/1kSRkXo9ejYIvyykP3/szmbhqYbBBtLHR7FNY/Nq") {
            if compare {
                print("Hash matches!")
            }
            else {
                print("Password doesn't match hashed value")
            }
        }
        else {
            print("Hash generation failed!")
        }
        
        let alertController = UIAlertController(title: "Credentials", message:"Your email is: \(email)\n Your password is: \(password) \n Your hashed password + salt is: \(self.hashedPassword)" , preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: "Continue", style: .Default, handler: nil))
        presentViewController(alertController, animated: true, completion: nil)
        
    }
    


}
