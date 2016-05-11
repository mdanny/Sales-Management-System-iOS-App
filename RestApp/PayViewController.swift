//
//  PayViewController.swift
//  RestApp
//
//  Created by Macrinici Dan on 5/1/16.
//  Copyright © 2016 Daniel Macrinici. All rights reserved.
//

import UIKit

class PayViewController: UITableViewController, UITextFieldDelegate {
    
    //Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var cardNumberTextField: UITextField!
    @IBOutlet weak var expireDateTextField: UITextField!
    @IBOutlet weak var cvcTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBOutlet var textFields: [UITextField]!
    
    // Delegate methods
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        return true
    }
    
    
    
//    @IBAction func pay(sender: AnyObject) {
//        //Initiate the card
//        var stripeCard = STPCard()
//        
//        // Split the expiration date to extract Month & Year
//        if self.expireDateTextField.text?.isEmpty == false {
//            let expDate = self.expireDateTextField.text?.componentsSeparatedByString("/")
//            let expMonth = UInt(expDate![0].Int()!)
//            let expYear = UInt(expDate![1].Int()!)
//            
//            // Send the card info to Stripe to get the token
//            stripeCard.number = self.cardNumberTextField.text
//            stripeCard.cvc = self.cvcTextField.text
//            stripeCard.expMonth = expMonth
//            stripeCard.expYear = expYear
//        }
    
//        var underlyingError: NSError?
//        stripeCard.validateCardReturningError(&underlyingError)
//        if underlyingError != nil {
//            self.spinner.stopAnimating()
//            self.handleError(underlyingError!)
//        return
//        }
//    
//        STPAPIClient.sharedClient().createTokenWithCard(stripeCard, completion: { (token, error) -> Void in
//            
//            if error != nil {
//                self.handleError(error!)
//                return
//            }
//            
//            self.postStripeToken(token!)
//        })
//    }
//    
//    func handleError(error: NSError) {
//        UIAlertView(title: "Please try again", message: error.localizedDescription, delegate: nil, cancelButtonTitle: "OK").show()
//    }
//    
}
