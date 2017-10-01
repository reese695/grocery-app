//
//  GroceryList.swift
//  grocery-app
//
//  Created by Reese Woodard on 5/29/17.
//  Copyright © 2017 Reese Woodard. All rights reserved.
//

import Foundation

class GroceryList {
    var modified: Date
    
    var name: String {
        didSet {
            modified = Date()
        }
    }
    
    var items: [GroceryItem]
    
    init(name: String) {
        self.name = name
        self.items = []
        modified = Date()
    }
    
    func encode() -> [String : Any] {
        var itemsArray: [[String : Any]] = [];
        for item in items {
            itemsArray.append(item.encode())
        }
        return [
            "modified" : modified,
            "name" : name,
            "items" : itemsArray
        ]
    }
    
    func decode(_ input: [String : Any]) {
        var convertedItems: [GroceryItem] = []
        for item in input["items"] as! [[String : Any]] {
            let newItem: GroceryItem = GroceryItem(name: "")
            newItem.decode(item)
            convertedItems.append(newItem)
        }
        modified = input["modified"] as! Date;
        items = convertedItems;
        name = input["name"] as! String;
    }
}
