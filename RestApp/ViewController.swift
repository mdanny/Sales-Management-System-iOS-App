//
//  ViewController.swift
//  RestApp
//
//  Created by Macrinici Dan on 4/20/16.
//  Copyright © 2016 Daniel Macrinici. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {

    @IBOutlet weak var tableView: UITableView!
    
    // Total calculation
    @IBOutlet weak var totalCartLabel: UILabel!
    
    var total: Double?
    
    var jsonObject: [String: AnyObject]?
    var namesArray: Array<String> = []
    var pricesArray: Array<Double> = []
    var amountsArray: Array<Int> = []
    var idArray: Array<String> = []
    
    // API data stored in private variables (TODO refactor to an associative array)
    internal private(set) var apiCategoryIndex: [String] = ["56f90fcd7ed4e3a5131002c7", "56f911477ed4e3a5131002d2", "56fcd6f4176d3c5614f83888", "56fcd6fb176d3c5614f83889", "57150681f3343345266963a5", "571931a446c9671e5ec1a1a1", "571933ad67a3bf03531c7f2f"]
    internal private(set) var apiCategoryName: [String] = ["Headphones", "Notebooks", "Smartphones", "Cameras", "test1", "conserve"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
//        print("TOTAL----------", self.total)
        
//        self.totalCartLabel.text = String(self.total)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        print("NAMES ARRAY FROM viewDidAppear: ---------------",self.namesArray)
        print("TOTAL FROM viewDidAppear: ---------------",self.total!)
        self.totalCartLabel?.text = String(self.total!)
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
        cell.priceLabel?.text = String(self.pricesArray[indexPath.row])
//        cell.totalLabel?.text = String(self.total[indexPath.section])
        
        return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == .Delete {
            print("Id is \(self.idArray[indexPath.row])")
            
            Alamofire.request(.DELETE, "http://46.101.104.55:3000/products_ios/\(self.apiCategoryIndex[6])/\(self.idArray[indexPath.row])")
            self.downloadAndUpdate()
        }
        else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    // Ensure that the tableview updates after we add another item
    func downloadAndUpdate() {
        
        // Refactoring (to delete the already populated cells)
        self.total = nil
        self.namesArray.removeAll()
        self.pricesArray.removeAll()
        self.amountsArray.removeAll()
        self.idArray.removeAll()
        
//        Alamofire.request(.GET, "http://46.101.104.55:3000/products_ios/\(self.apiCategoryIndex[6])").responseJSON {
//            response in
//            //print(response.request) // original URL request
//            print("This is the products_ios URL response",response.response) // URL response
//            //print(response.data) // server data
//            print("This is the products_ios response result: ",response.result) // result of response serialization
////            print("This is the URL response value",response.result.value)
//            if let JSON = response.result.value {
//                
//                self.jsonArray = JSON as? NSMutableArray
//                for item in self.jsonArray! {
//                    print(item["name"]!)
//                    let string = item["name"]!
//                    let id = item["_id"]! // NEW
//                    self.newArray.append(string! as! String)
//                    self.idArray.append(id! as! String) // NEW
//                }
//                
//                print("New array is \(self.newArray)")
//                
//                self.tableView.reloadData()
//            }
//        }
        
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
                    let cartProductPrice = object["item"]!!["price"]
                    
                    let cartProductAmount = object["quantity"]
                    
                    print("CART -----------> This is the product price: \(cartProductPrice), this is the product amount: \(cartProductAmount), this is the total price: \(cartTotal)")
                    
                    
                    self.namesArray.append(cartProductName)
                    self.pricesArray.append(cartProductPrice as! Double)
                    self.amountsArray.append(cartProductAmount as! Int)
                    self.idArray.append(cartProductId as! String) // NEW
                    self.total = cartTotal
                }
                
                
                print("The Names array is \(self.namesArray)")
                print("The Prices array is \(self.pricesArray)")
                
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        self.downloadAndUpdate()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

