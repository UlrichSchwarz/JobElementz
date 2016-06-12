//
//  ViewController.swift
//  jobElementz
//
//  Created by Ulrich Schwarz on 11.06.16.
//  Copyright © 2016 Ulrich Schwarz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    var innerProgress = 0.0
    
    let outerIntervalSeconds = 60
    let innerIntervalSeconds = 10
    
    
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
    
    
    
    @IBOutlet var progressView: ProgressView!
    @IBOutlet weak var outerTimerLabel: UILabel!
    
    @IBAction func resetTapped(sender: UIButton) {
        
       resetOuterTimer()
    }
    
    @IBAction func startStopTapped(sender: UIButton) {
        
        if !outerTimer.valid {
            startOuterTimer()
        } else {
            outerTimer.invalidate()
        }
    }
    
    func resetOuterTimer () {
        outerTimer.invalidate()
        outerTimerLabel.text = "0000"
        outerTotalTime = NSTimeInterval()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            }
    
    
    func outerTimerUpdate() {
        
        let seconds = getOuterTimerSeconds()
        outerProgress = outerTotalTime/Double(outerIntervalSeconds)
        outerTimerLabel.text = String(format: "%04d", seconds)
    }
    func getOuterTimerSeconds() -> Int {
        
        let now = NSDate.timeIntervalSinceReferenceDate()
        outerTotalTime += now - outerLastInterval
        outerLastInterval = now
        return Int(outerTotalTime)
    }
    
    func startOuterTimer() {
        
        let outerTimerSelector: Selector = #selector(ViewController.outerTimerUpdate)
        
        outerTimer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: outerTimerSelector, userInfo: nil, repeats: true)
        
        outerLastInterval = NSDate.timeIntervalSinceReferenceDate()
    }
    
}

