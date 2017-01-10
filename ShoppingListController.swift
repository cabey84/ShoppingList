//
//  ShoppingListController.swift
//  ShoppingList
//
//  Created by Chandi Abey  on 8/27/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation
import CoreData

class ShoppingListController {
    
    //create a singleton
    static let sharedController = ShoppingListController()
    
    //create an array to hold the list of items in the shopping list
    var items: [ShoppingList] {
        //create an NS fetch request
        let request = NSFetchRequest(entityName: "ShoppingList")
        //where to get the shoppinglist from, moc,
        let moc = Stack.sharedStack.managedObjectContext
        //NSFetchrequest can throw an error so we are going to account for throwing an error. when things come back wthey are managed objects so we want a type playlist with playlist properties which is why we are casting it as a type
        return (try? moc.executeFetchRequest(request)) as? [ShoppingList] ?? [ ]
        
    }
    
    //create a function to add items to the shopping list. This will be called in the tableviewcontroller UIAlert add item
    func addItem(itemName: String, isComplete: Bool) {
        _ = ShoppingList(itemName: itemName, isComplete: isComplete)
            saveToPersistentStore()
    }
    
    
    //create a function to delete items from the shopping list which will be called in the commitToEditing function in the tableViewController
    func deleteItem(item: ShoppingList) {
        if let moc = item.managedObjectContext {
        moc.deleteObject(item)
        saveToPersistentStore()
        }
    }
    
    //toggle complete function that is called in the tableview controller when the user clicks on the button and tapping is delegated to the larger table view by the cell
    func isCompleteToggle(item: ShoppingList) {
        item.isComplete = !item.isComplete.boolValue
        saveToPersistentStore()
        
    }
    
    
    func saveToPersistentStore() {
        let moc = Stack.sharedStack.managedObjectContext
        do {
            try moc.save()
        } catch {
            fatalError("There was a problem saving to persistent store.")
        }
        
    }
}