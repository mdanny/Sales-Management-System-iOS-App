//
//  Product.swift
//  RestApp
//
//  Created by Macrinici Dan on 6/9/16.
//  Copyright © 2016 Daniel Macrinici. All rights reserved.
//

import Foundation

class Product {
    var name, category, brand, supermarket, description, id: String?
    var price: Double?
    
    init(name: String?, category: String?, brand: String?, supermarket: String?, description: String?, id: String?, price: Double?) {
        self.name = name
        self.category = category
        self.brand = brand
        self.supermarket = supermarket
        self.description = description
        self.id = id
        self.price = price
    }
    
    convenience init() {
        self.init(name: "Unnamed", category: "No category", brand: "No brand", supermarket: "No supermarket", description: "No description", id: "No id", price: 0.0)
    }
    
}