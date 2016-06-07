//
//  ViewController.swift
//  RestApp
//
//  Created by Macrinici Dan on 4/20/16.
//  Copyright © 2016 Daniel Macrinici. All rights reserved.
//

import UIKit
import Alamofire
import RxAlamofire
import RxSwift

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {

    @IBOutlet weak var tableView: UITableView!
    
    // Total calculation
    @IBOutlet weak var totalCartLabel: UILabel!
    
    var total: Double?
    
    var jsonObject: [String: AnyObject]?
    var namesArray: Array<String> = []
    var pricesArray: Array<Double> = []
    var amountsArray: Array<Int> = []
    var imagesArray: Array<String> = []
    var idArray: Array<String> = []
    var imageObjects: Array<UIImage> = []
    
    // API data stored in private variables (TODO refactor to an associative array)
    internal private(set) var apiCategoryIndex: [String] = ["56f90fcd7ed4e3a5131002c7", "56f911477ed4e3a5131002d2", "56fcd6f4176d3c5614f83888", "56fcd6fb176d3c5614f83889", "57150681f3343345266963a5", "571931a446c9671e5ec1a1a1", "571933ad67a3bf03531c7f2f"]
    internal private(set) var apiCategoryName: [String] = ["Headphones", "Notebooks", "Smartphones", "Cameras", "test1", "conserve"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if self.total != nil {
            self.totalCartLabel?.text = String(self.total!)
            let userDefaults = NSUserDefaults.standardUserDefaults()
            userDefaults.setObject(Double((self.totalCartLabel?.text)!), forKey: "total")
        }
        
        self.tableView.reloadData()
    }

    // Adding delegate methods
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.namesArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MyCustomCell", forIndexPath: indexPath) as! CustomCell
        
        
        cell.nameLabel?.text = self.namesArray[indexPath.row]
        cell.amountLabel?.text = String(self.amountsArray[indexPath.row])
        cell.priceLabel?.text = String(Double(self.pricesArray[indexPath.row]))
        cell.productImage?.imageFromUrl(self.imagesArray[indexPath.row])
        
        return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == .Delete {
            
            Alamofire.request(.POST, "http://46.101.104.55:3000/remove", parameters: ["item": (self.idArray[indexPath.row]), "price": (self.pricesArray[indexPath.row])])
           
            self.totalCartLabel?.text = String(Double((self.totalCartLabel?.text)!)! - self.pricesArray[indexPath.row])
            
            self.namesArray.removeAtIndex(indexPath.row)
            self.pricesArray.removeAtIndex(indexPath.row)
            self.imagesArray.removeAtIndex(indexPath.row)
            self.idArray.removeAtIndex(indexPath.row)
            
            print("----------->NAMES-ARRAY<--------", self.namesArray)
            print("----------->PRICES-ARRAY<--------", self.pricesArray)
            print("----------->IMAGES-ARRAY<--------", self.imagesArray)
            
            
            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            //self.downloadAndUpdate()
            self.tableView.reloadData()
        }
        else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    // Ensure that the tableview updates after we add another item
    func downloadAndUpdate() {
        
        // Refactoring (to delete the already populated cells)
        self.totalCartLabel?.text = "0.0"
        self.total = nil
        self.namesArray.removeAll()
        self.pricesArray.removeAll()
        self.amountsArray.removeAll()
        self.imagesArray.removeAll()
        self.idArray.removeAll()
        
        
        Alamofire.request(.GET, "http://46.101.104.55:3000/cart_ios").responseJSON {
            response in
            //print(response.request) // original URL request
            print("This is the products_ios URL response",response.response) // URL response
            //print(response.data) // server data
            print("This is the cart response result: ",response.result) // result of response serialization
            print("This is the URL response value",response.result.value)
            if let JSON = response.result.value {
                
                self.jsonObject = JSON as? [String: AnyObject]
                print(self.jsonObject)
                
                
                let itemsArray = self.jsonObject!["items"] as! NSArray
                
                let cartTotal = self.jsonObject!["total"] as! Double
                
                for object in itemsArray {
                    
                    let cartProductName = object["item"]!!["name"] as! String
                    let cartProductId = object["_id"]! // NEW
                    let cartProductPrice = object["price"]
                    let cartProductAmount = object["quantity"]
                    let cartProductImage = object["item"]!!["image"]
                    
                    print("CART -----------> This is the product price: \(cartProductPrice), this is the product amount: \(cartProductAmount), this is the total price: \(cartTotal)")
                    
                    self.namesArray.append(cartProductName)
                    self.pricesArray.append(cartProductPrice as! Double)
                    self.amountsArray.append(cartProductAmount as! Int)
                    self.imagesArray.append(cartProductImage as! String)
                    self.idArray.append(cartProductId as! String) // NEW
                    self.total = cartTotal
                    
                }
                
            
                print("The Names array is \(self.namesArray)")
                print("The Prices array is \(self.pricesArray)")
                print("The IMAGE NAMES aray is \(self.imagesArray)")
                self.tableView.reloadData()
            }
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        self.downloadAndUpdate()
    }

}


extension UIImageView {
    public func imageFromUrl(urlString: String) {
        requestData(.GET, urlString)
            .observeOn(MainScheduler.instance)
            .subscribeNext { self.image = UIImage(data: $0.1) }
    }
}

