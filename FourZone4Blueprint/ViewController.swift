//
//  ViewController.swift
//  FourZone4Blueprint
//
//  Created by Ilia Tikhomirov on 28/02/16.
//  Copyright © 2016 Ilia Tikhomirov. All rights reserved.
//

import UIKit
import HealthKit

class ViewController: UIViewController {
    
    let healthKitStore:HKHealthStore = HKHealthStore()
    static let heartRateQuantityType = HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierHeartRate)

    let dataTypesToRead = NSSet(objects: heartRateQuantityType!)

    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        healthKitStore.requestAuthorizationToShareTypes(nil,
            readTypes: dataTypesToRead as? Set<HKObjectType>,
            completion: { (success, error) -> Void in
                if success {
                    print("success")
                } else {
                    print(error!.description)
                }
        })
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    


}

