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
    
    var apiName: NSString? 
    var apiCategory: NSString?
    var apiBrand: NSString?
    var apiSupermarket: NSString?
    var apiDescription: NSString?
    var apiPrice: NSString?

    //    var objQR: QRViewController?
//    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        objQR = QRViewController() // create the QRViewController instance
//    }
    
    
//    @IBAction func buttonTapped(sender: UIButton) {
//        
//        self.textView.text = objQR?.infoString
//        
//        Alamofire.request(.POST, "https://calm-forest-61690.herokuapp.com/todo", parameters: ["name": self.textView.text!])
//        self.navigationController!.popViewControllerAnimated(true)
//    }

    @IBAction func buttonTapped(sender: UIButton) {
        print("Name: \(self.apiName)")
        Alamofire.request(.POST, "http://46.101.104.55:3000/api/testcategory", parameters: ["name": (self.apiName)!, "category": (self.apiCategory)!, "brand": (self.apiBrand)!, "supermarket": (self.apiSupermarket)!, "description": (self.apiDescription)!, "price": (self.apiPrice)!])
        self.navigationController!.popViewControllerAnimated(true)
    }


}
