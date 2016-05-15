//
//  CollectionViewController.swift
//  RestApp
//
//  Created by Macrinici Dan on 5/13/16.
//  Copyright © 2016 Daniel Macrinici. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    let dateCellIdentifier = "DateCellIdentifier"
    let contentCellIdentifier = "ContentCellIdentifier"
    
    @IBOutlet weak var collectionView: UICollectionView!
    private var indexP: NSIndexPath?
    private var productsArray: [String] {
        return CollectionViewController.fetchProductNames()
    }
    private var brandsArray: [String] {
        return CollectionViewController.fetchProductBrands()
    }
    private var pricesArray: [Int] {
        return CollectionViewController.fetchProductPrices()
    }
    private var supermarketsArray: [String] {
        return CollectionViewController.fetchProductSupermarkets()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.registerNib(UINib(nibName: "DateCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: dateCellIdentifier)
        self.collectionView.registerNib(UINib(nibName: "ContentCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: contentCellIdentifier)
    }
    
    
    // MARK - UICollectionViewDataSource
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        if productsArray.isEmpty == true {
            return 1
        }
        return productsArray.count
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let cell = self.dateCellGenerator("Item's Name", cellForItemAtIndexPath: indexPath)
                return cell
            }
            
            else if indexPath.row == 1 {
                let cell = self.contentCellGenerator("Brand", cellForItemAtIndexPath: indexPath)
                return cell
                
            }
                
            else if indexPath.row == 2 {
                let cell = self.contentCellGenerator("Paid", cellForItemAtIndexPath: indexPath)
                return cell
            }
            
            
            else {
                let cell = self.contentCellGenerator("Supermarket", cellForItemAtIndexPath: indexPath)
                return cell
            }
        }
        
        else {
            if indexPath.row == 0 {
                let cell = self.dateCellGenerator(productsArray[indexPath.section - 1], cellForItemAtIndexPath: indexPath)
                
                return cell
            }
                
            else if indexPath.row == 1 {
                let cell = self.contentCellGenerator(brandsArray[indexPath.section - 1], cellForItemAtIndexPath: indexPath)
                
                return cell
            }
            
            else if indexPath.row == 2 {
                let cell = self.contentCellGenerator(String(pricesArray[indexPath.section - 1]), cellForItemAtIndexPath: indexPath)
                
                return cell
            }
                
            else {
                let cell = contentCellGenerator(supermarketsArray[indexPath.section - 1], cellForItemAtIndexPath: indexPath)
                return cell
            }
        }
    }
    
   static func fetchProductNames() -> [String] {
        var productNames: [String] = []
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let result = userDefaults.objectForKey("userProfile")
        for idx in 0..<result!.count {
            let elem = result![idx]["item"]!!["name"] as! String
            productNames.append(elem)
        }
        return productNames
    }
    
    static func fetchProductBrands() -> [String] {
        var brandNames: [String] = []
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let result = userDefaults.objectForKey("userProfile")
        for idx in 0..<result!.count {
            let elem = result![idx]["item"]!!["brand"] as! String
            brandNames.append(elem)
        }
        return brandNames
    }
    
    
    static func fetchProductPrices() -> [Int] {
        var productPrices: [Int] = []
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let result = userDefaults.objectForKey("userProfile")
        for idx in 0..<result!.count {
            let elem = result![idx]["item"]!!["price"] as! Int
            productPrices.append(elem)
        }
        return productPrices
    }
    
    static func fetchProductSupermarkets() -> [String] {
        var productSupermarkets: [String] = []
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let result = userDefaults.objectForKey("userProfile")
        for idx in 0..<result!.count {
            let elem = result![idx]["item"]!!["supermarket"] as! String
            productSupermarkets.append(elem)
        }
        return productSupermarkets
    }
    
    func contentCellGenerator(text: String, cellForItemAtIndexPath indexPath: NSIndexPath) -> ContentCollectionViewCell {
        let contentCell : ContentCollectionViewCell = collectionView .dequeueReusableCellWithReuseIdentifier(contentCellIdentifier, forIndexPath: indexPath) as! ContentCollectionViewCell
        contentCell.contentLabel.font = UIFont.systemFontOfSize(13)
        contentCell.contentLabel.textColor = UIColor.blackColor()
        contentCell.contentLabel.text = text
        if indexPath.section % 2 != 0 {
            contentCell.backgroundColor = UIColor(white: 242/255.0, alpha: 1.0)
        } else {
            contentCell.backgroundColor = UIColor.whiteColor()
        }
        
        return contentCell
    }
    
    func dateCellGenerator(text: String, cellForItemAtIndexPath indexPath: NSIndexPath) -> DateCollectionViewCell {
        let dateCell : DateCollectionViewCell = collectionView .dequeueReusableCellWithReuseIdentifier(dateCellIdentifier, forIndexPath: indexPath) as! DateCollectionViewCell
        dateCell.dateLabel.font = UIFont.systemFontOfSize(13)
        dateCell.dateLabel.textColor = UIColor.blackColor()
        dateCell.dateLabel.text = text
        if indexPath.section % 2 != 0 {
            dateCell.backgroundColor = UIColor(white: 242/255.0, alpha: 1.0)
        } else {
            dateCell.backgroundColor = UIColor.whiteColor()
        }
        
        return dateCell
    }
}

