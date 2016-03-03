//
//  MenuInterfaceController.swift
//  FourZone4Blueprint
//
//  Created by Ilia Tikhomirov on 28/02/16.
//  Copyright © 2016 Ilia Tikhomirov. All rights reserved.
//

import WatchKit
import Foundation

struct RowData{
    let name:String
    let imageName: String
}


class MenuInterfaceController: WKInterfaceController {

    @IBOutlet var tableView: WKInterfaceTable!
    
    let objects: [RowData] = [
        RowData(name: "Walk and Chill", imageName: "Walker"),
        RowData(name: "Fat Burning", imageName: "Sumo"),
        RowData(name: "Endurance", imageName: "Runner"),
        RowData(name: "Hardcore", imageName: "Skull")
    ]
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        
        setTitle("Fourzone")
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        let rows = Array(count: objects.count, repeatedValue: "Row")
        tableView.setRowTypes(rows)
        
        for(var i = 0; i < objects.count; i++){
            if let row = tableView.rowControllerAtIndex(i) as? TableRow {
                row.label.setText(objects[i].name)
                row.image.setImageNamed(objects[i].imageName)
                
                switch objects[i].name {
                
                case "Hardcore":
                    row.rowGroup.setBackgroundColor(UIColor(red: 0.816, green: 0.008, blue: 0.106, alpha: 1.0))
                case "Fat Burning":
                    row.rowGroup.setBackgroundColor(UIColor(red: 0.961, green: 0.651, blue: 0.137, alpha: 1.0))
                case "Endurance":
                    row.rowGroup.setBackgroundColor(UIColor(red: 0.961, green: 0.651, blue: 0.137, alpha: 1.0))
                case "Walk and Chill":
                    row.rowGroup.setBackgroundColor(UIColor(red: 0.29, green: 0.565, blue: 0.886, alpha: 1.0))
                    
                default:
                    row.rowGroup.setBackgroundColor(UIColor(red: 0.29, green: 0.565, blue: 0.886, alpha: 1.0))
                }
            }
        }
    }
    
    override func table(table: WKInterfaceTable, didSelectRowAtIndex rowIndex: Int) {
        
        presentControllerWithName("hrMeasure", context: objects[rowIndex].name)
        
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
