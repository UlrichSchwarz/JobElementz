//
//  ViewController.swift
//  jobElementz
//
//  Created by Ulrich Schwarz on 11.06.16.
//  Copyright © 2016 Ulrich Schwarz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    let outerIntervalSeconds = 12000
    let innerIntervalSeconds = 600
    
    
    let maxIntervals = 8.0
    var currentInterval = 1
    
    var outerTimer = NSTimer()
    var innerTimer = NSTimer()
    
    var outerTotalTime = NSTimeInterval()
    var innerTotalTime = NSTimeInterval()
    
    var outerLastInterval = NSTimeInterval()
    var innerLastInterval = NSTimeInterval()
    
    
    var outerProgress = 0.0 {
        didSet {
            if self.outerProgress == 0 {
                self.progressView.resetProgress()
            }
            self.progressView.updateOuterProgress(self.outerProgress)
        }
    }
    var innerProgress = 0.0 {
        didSet {
            if self.innerProgress == 0 {
                self.progressView.resetProgress()
            }
            self.progressView.updateInnerProgress(self.innerProgress)
        }
    }
    
    
    @IBOutlet var progressView: ProgressView!
    @IBOutlet weak var outerTimerLabel: UILabel!
    
    @IBAction func resetTapped(sender: UIButton) {
        
       resetOuterTimer()
       resetInnerTimer()
    }
    
    @IBAction func startStopTapped(sender: UIButton) {
        startInnerTimer()
        startOuterTimer()
//        if !outerTimer.valid {
//            startOuterTimer()
//            startInnerTimer()
//           
//        } else {
//            outerTimer.invalidate()
//        }
//        
//        if !innerTimer.valid {
//            startInnerTimer()
//            
//        } else {
//            innerTimer.invalidate()
//        }
    }
    
    func resetOuterTimer () {
        outerTimer.invalidate()
        outerTimerLabel.text = "0000"
        outerTotalTime = NSTimeInterval()
    }
    
    func resetInnerTimer () {
        innerTimer.invalidate()
        
        innerTotalTime = NSTimeInterval()    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            }
    
    
    func outerTimerUpdate() {
        
        let seconds = getOuterTimerSeconds()
        outerProgress = outerTotalTime/Double(outerIntervalSeconds)
        outerTimerLabel.text = String(format: "%04d", seconds)
    }
    func innerTimerUpdate() {
        
        let seconds = getInnerTimerSeconds()
        innerProgress = innerTotalTime/Double(innerIntervalSeconds)
        
    }
    
    func getOuterTimerSeconds() -> Int {
        
        let now = NSDate.timeIntervalSinceReferenceDate()
        outerTotalTime += now - outerLastInterval
        outerLastInterval = now
        return Int(outerTotalTime)
    }
    
    func getInnerTimerSeconds() -> Int {
        
        let now = NSDate.timeIntervalSinceReferenceDate()
        innerTotalTime += now - innerLastInterval
        innerLastInterval = now
        return Int(innerTotalTime)
    }
    
    func startOuterTimer() {
        
        let outerTimerSelector: Selector = #selector(ViewController.outerTimerUpdate)
        
        outerTimer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: outerTimerSelector, userInfo: nil, repeats: true)
        
        outerLastInterval = NSDate.timeIntervalSinceReferenceDate()
    }
    
    func startInnerTimer() {
        
        let innerTimerSelector: Selector = #selector(ViewController.innerTimerUpdate)
        
        innerTimer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: innerTimerSelector, userInfo: nil, repeats: true)
        
        innerLastInterval = NSDate.timeIntervalSinceReferenceDate()
    }
    
}

