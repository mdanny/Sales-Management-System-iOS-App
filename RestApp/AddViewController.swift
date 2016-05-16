//
//  AddViewController.swift
//  
//
//  Created by Macrinici Dan on 4/21/16.
//
//

//import Cocoa
import UIKit
import Alamofire

class AddViewController: UIViewController {

    @IBOutlet weak var textView: UITextField!
    
    var apiName: String?
    var apiCategory: String?
    var apiBrand: String?
    var apiSupermarket: String?
    var apiDescription: String?
    var apiPrice: Int?
    var apiId: String?


//    @IBAction func buttonTapped(sender: UIButton) {
//        print("Name: \(self.apiName)")
//        Alamofire.request(.POST, "http://46.101.104.55:3000/api/testcategory", parameters: ["name": (self.apiName)!, "category": (self.apiCategory)!, "brand": (self.apiBrand)!, "supermarket": (self.apiSupermarket)!, "description": (self.apiDescription)!, "price": (self.apiPrice)!])
//        self.navigationController!.popViewControllerAnimated(true)
//    }
    
    @IBAction func buttonTapped(sender: UIButton) {
        let URL = "http://46.101.104.55:3000/cart_ios"
//        let params = ["product_id": (self.apiId)!, "priceValue": (self.apiPrice)!, "quantity": "1"]
//        print("USER ID FROM CART: \(self.apiId!)\n")
//        print("PRICE VALUE FROM CART: \(self.apiPrice!)\n")
        print("The segue is working!")
        Alamofire.request(.POST, URL, parameters: ["product_id": (self.apiId)!, "priceValue": (self.apiPrice)!, "quantity": "1"])
        print("-------------\n")
        print("Operation has been done")
        self.navigationController!.popViewControllerAnimated(true)
    }


}
