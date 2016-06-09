//
//  SignupViewController.swift
//  RestApp
//
//  Created by Macrinici Dan on 6/7/16.
//  Copyright © 2016 Daniel Macrinici. All rights reserved.
//

import UIKit
import Alamofire

class SignupViewController: UIViewController {

    var textFields: [UITextField]!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var genderSegment: UISegmentedControl!
    @IBOutlet weak var yearSlider: UISlider!
    @IBOutlet weak var yearSliderLabel: UILabel!
    
    var responseContainer: NSHTTPURLResponse?
    
    var user = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textFields = [nameTextField, emailTextField, passwordTextField]
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        let arrayOfTextFields = textFields as NSArray
        let arrayIndex = arrayOfTextFields.indexOfObject(textField)
        
        if arrayIndex < arrayOfTextFields.count - 1 {
            let newTextField = arrayOfTextFields[arrayIndex + 1] as! UITextField
            let doneTextField = arrayOfTextFields[arrayIndex] as! UITextField
            newTextField.becomeFirstResponder()
            doneTextField.backgroundColor = UIColor.greenColor()
        } else {
            textField.resignFirstResponder()
            textField.backgroundColor = UIColor.greenColor()
        }
        return true
    }
    
    @IBAction func sliderValueChanged(sender: AnyObject) {
        yearSliderLabel.text = "\(Int(yearSlider.value))"
        user.yearOfBirth = Int(yearSlider.value)
        print(user.yearOfBirth)
    }
    
    @IBAction func signupButton(sender: AnyObject) {
        if (nameTextField.text!.isEmpty || emailTextField.text!.isEmpty || passwordTextField.text!.isEmpty) {
            let alertControllerFailure = UIAlertController(title: "Signup Error", message:"One or several fields have not been entered. Please enter them once again!\n" , preferredStyle: .Alert)
            alertControllerFailure.addAction(UIAlertAction(title: "Continue", style: .Default, handler: nil))
            presentViewController(alertControllerFailure, animated: true, completion: nil)
        }
        else {
            user.name = nameTextField.text!
            user.email = emailTextField.text!
            user.password = passwordTextField.text!
            
            if genderSegment.selectedSegmentIndex == 0 {
                user.gender = "male"
            }
            else if genderSegment.selectedSegmentIndex == 1 {
                user.gender = "female"
            }
            else {
                user.gender = "undefined"
            }
            
            Alamofire.request(.POST, "http://46.101.104.55:3000/signup", parameters: ["name": user.name, "email": user.email, "gender": user.gender, "password": user.password, "age": user.yearOfBirth])
//                .responseJSON {
//                response in
//                
//                if let JSON = response.response {
//                    self.responseContainer = JSON
//                    print("RESPONSE OBJECT: \n")
//                    print(self.responseContainer)
//                    print("URL:\n")
//                    print(self.responseContainer!.URL!)
//                    print("This is the URL response value",response.result.value)
//                    if let result = response.result.value {
//                    
//                        
//                        if String(self.responseContainer!.URL!) == "http://46.101.104.55:3000/profile_ios" {
//                            print("Signup Successful!")
//                        }
//                        else {
//                            print("Signup failed!")
//                        }
//                    }
//                }
//            }
        self.dismissViewControllerAnimated(true, completion: nil)
        }
    
    }
}
