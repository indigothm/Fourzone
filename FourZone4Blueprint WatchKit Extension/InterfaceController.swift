//
//  InterfaceController.swift
//  FourZone4Blueprint WatchKit Extension
//
//  Created by Ilia Tikhomirov on 28/02/16.
//  Copyright © 2016 Ilia Tikhomirov. All rights reserved.
//

import Foundation
import HealthKit
import WatchKit



class InterfaceController: WKInterfaceController {
    
    //Interface Outlets
    
    @IBOutlet var statusView: WKInterfaceLabel!
    @IBOutlet var ringView: WKInterfaceImage!
    @IBOutlet var percentageView: WKInterfaceLabel!
    @IBOutlet var bpmVIew: WKInterfaceLabel!
    
    //Workout Related Variables
    
    var workoutSession : HKWorkoutSession?
    var workoutType: String = "Walk and Chill"

    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        print(context)
        
        // Configure interface objects here.
        
        ringView.setImageNamed("Light")
        
        ringView.startAnimatingWithImagesInRange(NSMakeRange(0, 37), duration: 0.5, repeatCount: 1)
        percentageView.setText("")
        statusView.setText("Checking your HR")
        bpmVIew.setText("")
        
        switch context as! String {
            
        case "Hardcore":
            workoutType = "Hardcore"

        case "Fat Burning":
            workoutType = "Fat Burning"

        case "Endurance":
            workoutType = "Endurance"
            
        case "Walk and Chill":
            workoutType  = "Walk and Chill"

        default:
            workoutType  = "Walk and Chill"

            
        }
        
        hrActivator()
        
        _ = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: "update", userInfo: nil, repeats: true)
        
    }
    
    

    func update() {
        
        bpmVIew.setText(String(GetHeartRate.sharedInstance.HRRealVal) + " bpm")
        setUpCircles(Double(GetHeartRate.sharedInstance.HRRealVal), age: 18)
        
    }
    

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
        
        hrActivator()
    }
    
    
    func workoutSession(workoutSession: HKWorkoutSession, didFailWithError error: NSError) {
        // Do nothing for now
        NSLog("Workout error: \(error.userInfo)")
    }
    


    
    func hrActivator() {
        if (WorkoutManager.sharedInstance.workoutActive) {
            
            if WorkoutManager.sharedInstance.entryWorkout {
            
            //finish the current workout
            print("Finishing Workout")
            WorkoutManager.sharedInstance.workoutActive = false
            
            if let workout = self.workoutSession {
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
   
    
    func setUpCircles(bpm: Double, age: Int){
        
        let percent = bpm / (Double)(220 - age) * 100
        checkZone(Int(percent))
        self.percentageView.setText(String(Int(percent)) + "%")
        
        
        if(percent <= 90){
            setupNormalView(percent / 80 * 100)
        }
        else{
            setupOverloadView()
        }
        checkForWarning(percent, workoutType: self.workoutType)
    }
    
    func setupNormalView(percent: Double){
        let segFilled: Double = percent / 100 * 36
        ringView.startAnimatingWithImagesInRange(NSMakeRange(0, (Int)(segFilled)), duration: 1, repeatCount: 1)
    }
    
    func setupOverloadView(){
        ringView.startAnimatingWithImagesInRange(NSMakeRange(0, (Int)(37)), duration: 1, repeatCount: 1)
    }
    
    
    func checkForWarning(percent: Double, workoutType: String){
       
        //Light <60
        //Fat 60 to 70
        //70 to 90 endurance
        //90+ DANGER
        
        if(percent > 95){
            WKInterfaceDevice.currentDevice().playHaptic(.Failure)
        }
        else{
            switch workoutType{
            case "Walk and Chill":
                //always good
                break
                
            case "Fat Burning":
                if(percent < 60){
                    //Hurry Up
                    WKInterfaceDevice.currentDevice().playHaptic(.Success)
                }
                else if(percent > 70){
                    //too fast
                    WKInterfaceDevice.currentDevice().playHaptic(.Notification)
                }
            case "Endurance":
                if(percent < 70){
                    //Hurry Up
                    WKInterfaceDevice.currentDevice().playHaptic(.Success)
                }
                else if(percent > 90){
                    //too fast
                    WKInterfaceDevice.currentDevice().playHaptic(.Notification)
                }
                
                
            case "Hardcore":
                if(percent < 90){
                    //Hurry Up
                    WKInterfaceDevice.currentDevice().playHaptic(.Success)
                }
                default:print("crap")
            }
            
        }
    }
    
    
    
    
   }



