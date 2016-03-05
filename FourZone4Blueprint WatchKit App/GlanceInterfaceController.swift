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


class GlanceInterfaceController: WKInterfaceController {
    
    
    
    @IBOutlet var percentageView: WKInterfaceLabel!
    @IBOutlet var bpmVIew: WKInterfaceLabel!
    @IBOutlet var statusView: WKInterfaceLabel!
    
    var i = 0
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        print(context)
        
        // Configure interface objects here
        hrActivator()
        _ = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: "update", userInfo: nil, repeats: true)
        
    }
    
    
    func update() {
        bpmVIew.setText(String(GetHeartRate.sharedInstance.HRRealVal) + " bpm")
        percentageView.setText(GetHeartRate.sharedInstance.determinePercentage(Double(GetHeartRate.sharedInstance.HRRealVal), age: 18) + "%")
        checkZone(GetHeartRate.sharedInstance.HRRealVal)
        i++
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
        
        print("Finishing Workout")
        WorkoutManager.sharedInstance.workoutActive = false
        
        if let workout = WorkoutManager.sharedInstance.workoutSession {
            GetHeartRate.sharedInstance.healthStore.endWorkoutSession(workout)
        }
        
    }
    
  
    
    // MARK: - Actions
    func hrActivator() {
        if (WorkoutManager.sharedInstance.workoutActive) {
            
            if WorkoutManager.sharedInstance.entryWorkout {
                
                //finish the current workout
                print("Finishing Workout")
                WorkoutManager.sharedInstance.workoutActive = false
                
                if let workout = WorkoutManager.sharedInstance.workoutSession {
                    GetHeartRate.sharedInstance.healthStore.endWorkoutSession(workout)
                }
                
            }
            
        } else {
            
            //start a new workout
            print("Starting Workout")
            WorkoutManager.sharedInstance.workoutActive = true
            WorkoutManager.sharedInstance.startWorkout()
            
        }
        
    }

    func checkZone(percent: Int) {
        if (percent < 60) {
            statusView.setText("Low Intencity Zone")
        } else if (60 < percent && percent < 70){
            statusView.setText("Fat Burning Zone")
        } else if (70 < percent && percent < 80) {
            statusView.setText("Endurance Improvement")
        } else if (80 < percent && percent < 90) {
            statusView.setText("Maximum Perfomance")
        } else if (percent > 90) {
            statusView.setText("Danger")
        }
    }
    
    
    
    
}
