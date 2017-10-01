//
//  GroceryItemViewController.swift
//  grocery-app
//
//  Created by Reese Woodard on 5/29/17.
//  Copyright © 2017 Reese Woodard. All rights reserved.
//

import UIKit

class GroceryItemViewController: UIViewController {
    
    var currentItem: GroceryItem?
    @IBOutlet weak var nameField: UITextField!
    @IBAction func nameChanged(_ sender: UITextField) {
        currentItem?.name = nameField.text!
    }
    @IBOutlet weak var quantityField: UITextField!
    @IBAction func quantityChanged(_ sender: UITextField) {
        currentItem?.quantity = Int(quantityField.text!) ?? 1
    }
    @IBOutlet weak var storeField: UITextField!
    @IBAction func storeChanged(_ sender: UITextField) {
        currentItem?.store = storeField.text!
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let cur = currentItem { // fill text fields with correct data (name, quantity, store) for given item
            nameField.text = cur.name
            quantityField.text = "\(cur.quantity)"
            storeField.text = cur.store
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
