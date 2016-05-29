//
//  RegistrationViewController0.swift
//  RestApp
//
//  Created by Macrinici Dan on 5/19/16.
//  Copyright © 2016 Daniel Macrinici. All rights reserved.
//

import UIKit

class RegistrationViewController0: UIViewController, UIScrollViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var genderSegmentControl: UISegmentedControl!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
   
    var textFields: [UITextField]!
    
    // vars to store text name and surname
    var name: String?
    var surname: String?
    var gender: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        textFields = [nameTextField, surnameTextField]
        // Handle the text field’s user input through delegate callbacks.
        nameTextField.delegate = self
        surnameTextField.delegate = self
        
        if genderSegmentControl.selectedSegmentIndex == 0 {
            self.gender = "male"
        } else if genderSegmentControl.selectedSegmentIndex == 1 {
            gender = "female"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
       
        let arrayOfTextFields = textFields as NSArray
        let arrayIndex = arrayOfTextFields.indexOfObject(textField)
        
        if arrayIndex < arrayOfTextFields.count - 1 {
            let newTextField = arrayOfTextFields[arrayIndex + 1] as! UITextField
            let doneTextField = arrayOfTextFields[arrayIndex] as! UITextField
            newTextField.becomeFirstResponder()
            doneTextField.backgroundColor = UIColor.grayColor()
        } else {
            textField.resignFirstResponder()
            textField.backgroundColor = UIColor.grayColor()
        }
        
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        self.name = nameTextField.text!
        self.surname = surnameTextField.text!
        print("Hello \(self.name!) \(self.surname!)")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
