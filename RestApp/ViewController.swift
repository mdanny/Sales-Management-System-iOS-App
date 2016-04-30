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
    
    var jsonArray: NSMutableArray?
    var newArray: Array<String> = []
    var idArray: Array<String> = []
//    var objQR: QRViewController?
    
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
        self.tableView.reloadData()
    }

    // Adding delegate methods
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.newArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) 
        
        cell.textLabel?.text = self.newArray[indexPath.row]
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
        self.newArray.removeAll()
        self.idArray.removeAll()
        
        Alamofire.request(.GET, "http://46.101.104.55:3000/products_ios/\(self.apiCategoryIndex[6])").responseJSON {
            response in
            //print(response.request) // original URL request
            //print(response.response) // URL response
            //print(response.data) // server data
            print(response.result) // result of response serialization
            
            if let JSON = response.result.value {
                
                self.jsonArray = JSON as? NSMutableArray
                for item in self.jsonArray! {
                    print(item["name"]!)
                    let string = item["name"]!
                    let id = item["_id"]! // NEW
                    self.newArray.append(string! as! String)
                    self.idArray.append(id! as! String) // NEW
                }
                
                print("New array is \(self.newArray)")
                
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

