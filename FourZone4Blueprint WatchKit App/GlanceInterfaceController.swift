//
//  GlanceInterfaceController.swift
//  FourZone4Blueprint
//
//  Created by Ilia Tikhomirov on 03/03/16.
//  Copyright © 2016 Ilia Tikhomirov. All rights reserved.
//

import Foundation
import HealthKit
import WatchKit


class GlanceInterfaceController: WKInterfaceController, HKWorkoutSessionDelegate {
    
    @IBOutlet var percentageView: WKInterfaceLabel!
    @IBOutlet var bpmVIew: WKInterfaceLabel!
    
    let healthStore = HKHealthStore()
    var i = 0
    var workoutActive = false
    var workoutSession : HKWorkoutSession?
    let heartRateUnit = HKUnit(fromString: "count/min")
    var anchor = HKQueryAnchor(fromValue: Int(HKAnchoredObjectQueryNoAnchor))
    
    // var hardData = [60.0,70.0,63.0,76.0,68.0,62.0,78.0,84.0,75.0,61.0,65.0,78.0]
    
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        print(context)
        
        // Configure interface objects here
        startBtnTapped()
        var timer = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: "update", userInfo: nil, repeats: true)
        
    }
    
    
    func update() {
        bpmVIew.setText(String(HRRealVal) + " bpm")
        determinePercentage(Double(HRRealVal))
        i++
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
        
        startBtnTapped()
    }
    
    func workoutSession(workoutSession: HKWorkoutSession, didChangeToState toState: HKWorkoutSessionState, fromState: HKWorkoutSessionState, date: NSDate) {
        switch toState {
        case .Running:
            workoutDidStart(date)
        case .Ended:
            workoutDidEnd(date)
        default:
            print("Unexpected state \(toState)")
        }
    }
    
    func workoutSession(workoutSession: HKWorkoutSession, didFailWithError error: NSError) {
        // Do nothing for now
        NSLog("Workout error: \(error.userInfo)")
    }
    
    func workoutDidStart(date : NSDate) {
        print("Workout did start")
        if let query = createHeartRateStreamingQuery(date) {
            print("Using query")
            healthStore.executeQuery(query)
            
        } else {
            print("cannot start")
        }
    }
    
    func workoutDidEnd(date : NSDate) {
        if let query = createHeartRateStreamingQuery(date) {
            healthStore.stopQuery(query)
        } else {
            //label.setText("cannot stop")
        }
    }
    
    // MARK: - Actions
    func startBtnTapped() {
        if (self.workoutActive) {
            //finish the current workout
            self.workoutActive = false
            //       self.startStopButton.setTitle("Start")
            print("Finishing Workout")
            
            if let workout = self.workoutSession {
                healthStore.endWorkoutSession(workout)
            }
        } else {
            //start a new workout
            self.workoutActive = true
            //     self.startStopButton.setTitle("Stop")
            startWorkout()
            
            print("Starting Workout")
        }
        
    }
    
    func startWorkout() {
        self.workoutSession = HKWorkoutSession(activityType: HKWorkoutActivityType.CrossTraining, locationType: HKWorkoutSessionLocationType.Indoor)
        self.workoutSession?.delegate = self
        healthStore.startWorkoutSession(self.workoutSession!)
    }
    
    func createHeartRateStreamingQuery(workoutStartDate: NSDate) -> HKQuery? {
        // adding predicate will not work
        
        let predicate = HKQuery.predicateForSamplesWithStartDate(workoutStartDate, endDate: nil, options: HKQueryOptions.None)
        print("Entered queury")
        guard let quantityType = HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierHeartRate) else { return nil }
        
        let heartRateQuery = HKAnchoredObjectQuery(type: quantityType, predicate: nil, anchor: anchor, limit: Int(HKObjectQueryNoLimit)) { (query, sampleObjects, deletedObjects, newAnchor, error) -> Void in
            // guard let newAnchor = newAnchor else {return}
            // self.anchor = newAnchor
            self.updateHeartRate(sampleObjects)
            print("Query is configured")
        }
        
        heartRateQuery.updateHandler = {(query, samples, deleteObjects, newAnchor, error) -> Void in
            // self.anchor = newAnchor!
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
    
    func determinePercentage(bpm: Double){
        let AGE = 18
        let percent = bpm / (Double)(220 - AGE) * 100
        percentageView.setText(String(percent))
        
    }
    
    
}
