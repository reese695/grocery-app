//
//  GroceryItem.swift
//  grocery-app
//
//  Created by Reese Woodard on 5/29/17.
//  Copyright © 2017 Reese Woodard. All rights reserved.
//

import Foundation

class GroceryItem {
    var quantity: Int
    
    var store: String?
    
    var name: String
    
    init(name: String) {
        self.name = name
        self.quantity = 1
    }
    
    func encode() -> [String: Any] {
        return [
            "quantity" : quantity,
            "store" : store ?? "",
            "name" : name
        ]
    }
    
    func decode(_ input: [String: Any]) {
        quantity = input["quantity"] as! Int;
        store = input["store"] as? String;
        name = input["name"] as! String;
    }
}
