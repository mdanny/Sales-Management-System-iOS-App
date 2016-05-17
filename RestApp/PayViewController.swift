//
//  PayViewController.swift
//  RestApp
//
//  Created by Macrinici Dan on 5/1/16.
//  Copyright © 2016 Daniel Macrinici. All rights reserved.
//

import UIKit
import Stripe
import Alamofire

class PayViewController: UIViewController, STPPaymentCardTextFieldDelegate {
    
    //Outlets
    
    @IBOutlet weak var payButton: UIButton!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    
    
    private var uid: String {
        return PayViewController.retrieveUser()
    }
    var stripeInfo: AnyObject?
    
    // Delegate methods
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        return true
    }
    
    let paymentTextField = STPPaymentCardTextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        paymentTextField.frame = CGRectMake(15, 199, CGRectGetWidth(self.view.frame) - 30, 44)
        paymentTextField.delegate = self
        view.addSubview(paymentTextField)
        payButton.hidden = true;
    }
    
    func paymentCardTextFieldDidChange(textField: STPPaymentCardTextField) {
        if textField.valid {
            payButton.hidden = false
        }
    }
    
    @IBAction func payButtonAction(sender: AnyObject) {
        let card = paymentTextField.cardParams
        
        STPAPIClient.sharedClient().createTokenWithCard(card, completion: {(token, error) -> Void in
            if let error = error {
                print(error)
            }
            else if let token = token {
                print(token)
                self.chargeUsingToken(token)
            }
        })
    }
    
    func chargeUsingToken(token: STPToken) {
        let requestString = "http://46.101.104.55:3000/payment_ios"
//        let requestString = "https://hidden-forest-16950.herokuapp.com/charge.php"
        let params = ["stripeToken": token.tokenId, "stripeMoney": "100", "currency": "usd", "description": self.uid]
        
        Alamofire.request(.POST, requestString, parameters: params)
            .responseJSON { response in
                print("ORIGINAL URL REQUEST ------------->",response.request) // original URL request
                print("URL RESPONSE ----------->",response.response) // URL response
                print("RESPONSE DATA: ----------->",response.data) // server data
                print("RESPONSE RESULT: ---------->",response.result) // result of response serialization
                
                if let JSON = response.result.value {
                    print("JSON: -------------> \(JSON)")
                }
        }
    }
    
    static func retrieveUser() -> String {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let result = userDefaults.objectForKey("userId")
        return result as! String
    }
}
