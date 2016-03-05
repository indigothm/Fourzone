//
//  WorkoutManager.swift
//  FourZone4Blueprint
//
//  Created by Ilia Tikhomirov on 05/03/16.
//  Copyright © 2016 Ilia Tikhomirov. All rights reserved.
//

import Foundation
import WatchKit
import HealthKit

class WorkoutManager: NSObject, HKWorkoutSessionDelegate {
    
   static let sharedInstance = WorkoutManager()
    
   var workoutSession : HKWorkoutSession?
   var workoutActive = false
   var entryWorkout = false
    
    func startWorkout() {
        self.workoutSession = HKWorkoutSession(activityType: HKWorkoutActivityType.CrossTraining, locationType: HKWorkoutSessionLocationType.Indoor)
        self.workoutSession?.delegate = self
        GetHeartRate.sharedInstance.healthStore.startWorkoutSession(self.workoutSession!)
    }
    
    func workoutSession(workoutSession: HKWorkoutSession, didChangeToState toState: HKWorkoutSessionState, fromState: HKWorkoutSessionState, date: NSDate) {
        dispatch_async(dispatch_get_main_queue()) {
            switch toState {
            case .Running:
                
                print("WORKOUT IS ALREADY RUNNING")
                
                self.workoutDidStart(date)
            case .Ended:
                self.workoutDidEnd(date)
            default:
                print("unexpected \(toState)")
            }
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
        }
    }
    
    
}