//
//  ShoppingListTableViewController.swift
//  ShoppingList
//
//  Created by Chandi Abey  on 8/27/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class ShoppingListTableViewController: UITableViewController, ButtonTableViewCellDelegate {

    
    @IBOutlet weak var addItemButton: UIBarButtonItem!
    
    
    @IBAction func addItemButtonTapped(sender: AnyObject) {
        showAlert()
        tableView.reloadData()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        showAlert()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    
    func showAlert() {
        var itemTextField: UITextField?
        //initializes a UIAlertController
        let alertController = UIAlertController(title: "Add Item", message: "Please add an item to your shopping list", preferredStyle: .Alert)
        //allows users to enter their item in the list
        alertController.addTextFieldWithConfigurationHandler { (textField) in
            //give properties to alertcontroller
            textField.placeholder = "Enter item here"
            //give it a keyboard
            textField.keyboardType = .NumberPad
            
            itemTextField = textField
        }
    
        
        //create actions - cancel and add actions
        let addItemAction = UIAlertAction(title: "Add", style: .Default) { (UIAlertAction) in
        
            guard let itemText = itemTextField?.text else { return }
                ShoppingListController.sharedController.addItem(itemText, isComplete: false)
                self.tableView.reloadData()
    
            }
        
        let cancelItemAction = UIAlertAction(title: "Cancel"
            , style: .Cancel) { (_) in

        }

        //add actions
        alertController.addAction(addItemAction)
        alertController.addAction(cancelItemAction)
        
        //presents the actual alert
        presentViewController(alertController, animated: true , completion: nil)
        
    }
  
    

    


    // MARK: - Table view data source


    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ShoppingListController.sharedController.items.count
    }

   
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("itemCell", forIndexPath: indexPath) as? ButtonTableViewCell ?? ButtonTableViewCell() 
        
        // Configure the cell...
        //we want to access what is in the array and pull out each item
        let item = ShoppingListController.sharedController.items[indexPath.row]
        //calling the updateWithItem function defined in the tableViewCell file to update the name and button tapped or not properties
        cell.updateWithItem(item)
        //when the button is pressed in the table view cell, tableViewcontroller acts as the delegate that will implement the button action so self refers to tableviewcontroller
        cell.delegate = self
        return cell
    }
   
   
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            //Delete the item using the function defined in the model controller
            let item = ShoppingListController.sharedController.items[indexPath.row] 
            ShoppingListController.sharedController.deleteItem(item)
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    //implementing the function required by the delegator cell
    func buttonCellButtonTapped(cell: ButtonTableViewCell) {
        //find the cell selected by user
        guard let indexPath = tableView.indexPathForCell(cell) else { return }
        //find the item
        let item = ShoppingListController.sharedController.items[indexPath.row]
        ShoppingListController.sharedController.isCompleteToggle(item)
         tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }
    


}
