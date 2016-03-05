//
//  ExtensionDelegate.swift
//  FourZone4Blueprint WatchKit Extension
//
//  Created by Ilia Tikhomirov on 28/02/16.
//  Copyright © 2016 Ilia Tikhomirov. All rights reserved.
//

import WatchKit
import HealthKit

class ExtensionDelegate: NSObject, WKExtensionDelegate {
    
    var workoutSession : HKWorkoutSession?

    func applicationDidFinishLaunching() {
        // Perform any final initialization of your application.
        
        if let _ = self.workoutSession {
            WorkoutManager.sharedInstance.workoutActive = true
            WorkoutManager.sharedInstance.entryWorkout = true
        }
        
    }

    func applicationDidBecomeActive() {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillResignActive() {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, etc.
        
        print("I am closing now")
       
        
        //TODO: This one is broken - probably pass a wrong workout session
        if let workout = self.workoutSession {
            print(workout)
            print("Killing workout")
            GetHeartRate.sharedInstance.healthStore.endWorkoutSession(workout)
        }
        
    }
    

}
