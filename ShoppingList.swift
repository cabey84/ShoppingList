//
//  ShoppingList.swift
//  ShoppingList
//
//  Created by Chandi Abey  on 8/27/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation
import CoreData


class ShoppingList: NSManagedObject {

// Insert code here to add functionality to your managed object subclass
    
    //first add a convenience initializer to initialize managed object context
    convenience init?(itemName: String, isComplete: Bool = false, context: NSManagedObjectContext = Stack.sharedStack.managedObjectContext) {
    
    
        //managed object needs to identify the entity and context to find where we are in core data
        guard let entity = NSEntityDescription.entityForName("ShoppingList", inManagedObjectContext: context) else { return nil }
        
        //initialize entity and context
        self.init(entity: entity, insertIntoManagedObjectContext: context)
    
        //initialize other properties
        self.itemName = itemName
        self.isComplete = isComplete
    
    }
}