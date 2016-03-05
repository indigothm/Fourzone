//
//  GetHeartRate.swift
//  FourZone4Blueprint
//
//  Created by Ilia Tikhomirov on 04/03/16.
//  Copyright © 2016 Ilia Tikhomirov. All rights reserved.
//

import Foundation
import HealthKit
import WatchKit

class GetHeartRate {
    
    static let sharedInstance = GetHeartRate()
    
    let healthStore = HKHealthStore()
    let heartRateUnit = HKUnit(fromString: "count/min")
    var anchor = HKQueryAnchor(fromValue: Int(HKAnchoredObjectQueryNoAnchor))
    
    func createHeartRateStreamingQuery(workoutStartDate: NSDate) -> HKQuery? {
        
        _ = HKQuery.predicateForSamplesWithStartDate(workoutStartDate, endDate: nil, options: HKQueryOptions.None)
        print("Entered queury")
        guard let quantityType = HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierHeartRate) else { return nil }
        
        let heartRateQuery = HKAnchoredObjectQuery(type: quantityType, predicate: nil, anchor: anchor, limit: Int(HKObjectQueryNoLimit)) { (query, sampleObjects, deletedObjects, newAnchor, error) -> Void in
            self.updateHeartRate(sampleObjects)
            print("Query is configured")
        }
        
        heartRateQuery.updateHandler = {(query, samples, deleteObjects, newAnchor, error) -> Void in
            self.updateHeartRate(samples)
            print("Updating sample")
            print(samples)
        }
        return heartRateQuery
    }
    
    
    func updateHeartRate(samples: [HKSample]?) {
        print("Entered updateHR")
        guard let heartRateSamples = samples as? [HKQuantitySample] else {
            
            print("No HR detected")
            
            return
        }
        
        dispatch_async(dispatch_get_main_queue()) {
            print("Enter async")
            guard let sample = heartRateSamples.first else{return}
            let value = sample.quantity.doubleValueForUnit(self.heartRateUnit)
            print(String(UInt16(value)))
            //HERE IS THE VALUE
            self.HRRealVal = Int(value)
            
            // retrieve source from sample
            print(sample.sourceRevision.source.name)
            
        }
    }
    
    var HRRealVal: Int = 0
    
    var workoutType: String = "Walk and Chill"
    
    func determinePercentage(bpm: Double, age: Int) -> String {
        let percent = bpm / (Double)(220 - age) * 100
        return String(percent)
    }
    
    

    
}