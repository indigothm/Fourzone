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
    
    var workoutActive = false
    var workoutSession : HKWorkoutSession?
         var i = 0
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        print(context)
        
        // Configure interface objects here
        startBtnTapped()
        _ = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: "update", userInfo: nil, repeats: true)
        
    }
    
    
    func update() {
        bpmVIew.setText(String(GetHeartRate.sharedInstance.HRRealVal) + " bpm")
        
        
        percentageView.setText(GetHeartRate.sharedInstance.determinePercentage(Double(GetHeartRate.sharedInstance.HRRealVal), age: 18))
        
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
        if let query = GetHeartRate.sharedInstance.createHeartRateStreamingQuery(date) {
            print("Using query")
            GetHeartRate.sharedInstance.healthStore.executeQuery(query)
            
        } else {
            print("cannot start")
        }
    }
    
    func workoutDidEnd(date : NSDate) {
        if let query = GetHeartRate.sharedInstance.createHeartRateStreamingQuery(date) {
            GetHeartRate.sharedInstance.healthStore.stopQuery(query)
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
                GetHeartRate.sharedInstance.healthStore.endWorkoutSession(workout)
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
        GetHeartRate.sharedInstance.healthStore.startWorkoutSession(self.workoutSession!)
    }
    
    
    
    
    
}
