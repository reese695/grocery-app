//
//  GroceryLists.swift
//  grocery-app
//
//  Created by Reese Woodard on 5/29/17.
//  Copyright © 2017 Reese Woodard. All rights reserved.
//

import UIKit

class GroceryListsView: UITableViewController {
    
    var allLists: [GroceryList] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Saved data:")
        print(UserDefaults.standard.value(forKey: "groceryLists") ?? "Nothing found, using sample data")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData() // refresh table view to make sure new lists appear
    }
    
    func saveData (){ // encode and save current lists
        if (allLists.count == 0){
            UserDefaults.standard.removeObject(forKey: "groceryLists") // nothing to save, clear user defaults
        }
        else {
            let toSave = encode(); // encode everything
            UserDefaults.standard.setValue(toSave, forKey: "groceryLists") // save to user defaults
        }
    }
    
    func restoreData (){ // initialize data structures upon loading app
        if (allLists.count == 0){ // check if data needs to be restored
            if let savedLists = UserDefaults.standard.value(forKey: "groceryLists"){
                decode(savedLists as! [[String : Any]]) // restored saved values
            }
            else {
                createSampleData() // or use sample data if nothing was saved
            }
        }
    }
    
    func encode() -> [[String : Any]] { // iterates through grocery lists and encodes each to an array of dictionaries
        var encodedLists: [[String : Any]] = [];
        for list in allLists {
            encodedLists.append(list.encode());
        }
        return encodedLists;
    }
    
    func decode(_ savedLists : [[String : Any]]){ // decodes saved lists
        for list in savedLists {
            let newList: GroceryList = GroceryList(name: "")
            newList.decode(list)
            allLists.append(newList)
        }
        
    }
    
    func createSampleData(){ // create a sample grocery list for new users
        let testItem = GroceryItem(name: "Apple")
        let testItem2 = GroceryItem(name: "Oranges")
        let testItem3 = GroceryItem(name: "Flour")
        let testList = GroceryList(name: "Sample List")
        
        testList.items.append(testItem) // add item to list
        testList.items.append(testItem2) // add item to list
        testList.items.append(testItem3) // add item to list
        allLists.append(testList) // add list to array of lists
        showWelcome() // show welcome to new user
    }
    
    func showWelcome() {
        let alert = UIAlertController(title: "Welcome!", message: "We created a sample grocery list to get you started. Feel free to rename or delete it", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Continue", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allLists.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groceryList", for: indexPath)

        cell.textLabel?.text = allLists[indexPath.row].name
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy h:mm a"
        
        cell.detailTextLabel?.text = formatter.string(from: allLists[indexPath.row].modified)

        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            allLists.remove(at: indexPath.row) // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let moveList = allLists[fromIndexPath.row] // create copy
        allLists.remove(at: fromIndexPath.row) // remove from current position
        allLists.insert(moveList, at: to.row) // insert at new position
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showList",
            let singleListView = segue.destination as? GroceryListView,
            let indexPath = tableView.indexPathForSelectedRow {
            singleListView.currentList = allLists[indexPath.row]
        }
        if segue.identifier == "newList",
            let singleListView = segue.destination as? GroceryListView {
            allLists.append(GroceryList(name: "New List")) // Create new grocery list and add it to allLists
            singleListView.currentList = allLists.last // Set currentList in destination to newly created GroceryList
        }

    }

}
