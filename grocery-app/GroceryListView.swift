//
//  GroceryListView.swift
//  grocery-app
//
//  Created by Reese Woodard on 5/29/17.
//  Copyright © 2017 Reese Woodard. All rights reserved.
//

import UIKit

class GroceryListView: UITableViewController {
    
    var currentList: GroceryList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Change view title to match currentList's name
        self.navigationItem.title = currentList?.name
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Refresh list name (to allow for renaming list)
        self.navigationItem.title = currentList?.name
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentList?.items.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groceryItem", for: indexPath)

        cell.textLabel?.text = currentList?.items[indexPath.row].name

        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            currentList?.items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let moveItem = currentList?.items[fromIndexPath.row] // create copy
        currentList?.items.remove(at: fromIndexPath.row) // remove from current position
        currentList?.items.insert(moveItem!, at: to.row) // insert at new position

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showItem",
            let singleItemView = segue.destination as? GroceryItemViewController,
            let indexPath = tableView.indexPathForSelectedRow {
            singleItemView.currentItem = currentList?.items[indexPath.row]
        }
        if segue.identifier == "newItem",
            let singleItemView = segue.destination as? GroceryItemViewController {
            currentList?.items.append(GroceryItem(name: "")) // Create new grocery item and add it to currentList
            singleItemView.currentItem = currentList?.items.last // Set currentItem in destination to newly created GroceryItem
        }
        if segue.identifier == "showOptions",
            let optionsView = segue.destination as? EditListViewController {
            optionsView.currentList = currentList
        }
    }

}
