//
//  ButtonTableViewCell.swift
//  ShoppingList
//
//  Created by Chandi Abey  on 8/27/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit


class ButtonTableViewCell: UITableViewCell {
    
    //the delegate here will be the TableView, this code requires the delegate to adopt the protocol, at this point switch over to tableview to adopt protocol
    weak var delegate: ButtonTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    

    @IBOutlet weak var itemLabel: UILabel!
    
    
    @IBOutlet weak var completeButton: UIButton!
    
    //when the complete button is tapped, we dont want to handle this task, so we call the delegate
    @IBAction func completeButtonTapped(sender: AnyObject) {
        if let delegate = delegate {
    //if the delegate has been assigned, we call the delegate protocol and we pass in the entire cell
            delegate.buttonCellButtonTapped(self)
        }
    }
    
    //function called in cellforrow table view controller
    func updateWithItem(item: ShoppingList) {
        itemLabel.text? = item.itemName
        updateButton(item.isComplete.boolValue)
        
    }

    //this function will be called in the updateWithItem above which in turn will be called in the delegate (tableviewcontroller in the cellforrowatindexpath where we are defining the cell's properties)
    func updateButton(isComplete: Bool) {
        if isComplete {
            completeButton.setImage(UIImage(named:"complete"), forState: .Normal)
        }  else {
            completeButton.setImage(UIImage(named:"incomplete"), forState: .Normal)
        }
    
    }
    
}





//protocol to delegate handling of button being toggled from complete to not compelte
protocol ButtonTableViewCellDelegate: class {
    func buttonCellButtonTapped(cell: ButtonTableViewCell)
}