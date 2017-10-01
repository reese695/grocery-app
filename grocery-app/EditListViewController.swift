//
//  EditListViewController.swift
//  grocery-app
//
//  Created by Reese Woodard on 5/31/17.
//  Copyright © 2017 Reese Woodard. All rights reserved.
//

import UIKit

class EditListViewController: UIViewController {
    
    var currentList: GroceryList?
    
    @IBOutlet weak var listName: UITextField!
    @IBAction func nameChanged(_ sender: UITextField) {
        currentList?.name = listName.text!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let list = currentList {
            listName.text = list.name
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
