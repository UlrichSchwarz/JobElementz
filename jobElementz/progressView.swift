//
//  progressView.swift
//  jobElementz
//
//  Created by Ulrich Schwarz on 11.06.16.
//  Copyright © 2016 Ulrich Schwarz. All rights reserved.
//

import UIKit

class ProgressView: UIView {
    
    
    
    let π = CGFloat(M_PI)
    let outerStrokeColor = UIColor.lightGrayColor()
    let innerStrokeColor = UIColor.lightGrayColor()
    
    var outerProgressLine = CAShapeLayer()
    var innerProgressLine = CAShapeLayer()
    
    var outerCurrentProgress: CGFloat {
        get {
            return outerProgressLine.strokeEnd
        }
        set {
            if newValue > 1 {
                outerProgressLine.strokeEnd = 1
            } else if newValue < 0 {
                outerProgressLine.strokeEnd = 0
            } else {
                outerProgressLine.strokeEnd = newValue
            }
        }
    }
    var innerCurrentProgress: CGFloat {
        get {
            return innerProgressLine.strokeEnd
        }
        set {
            if newValue > 1 {
                innerProgressLine.strokeEnd = 1
            } else if newValue < 0 {
                innerProgressLine.strokeEnd = 0
            } else {
                innerProgressLine.strokeEnd = newValue
            }
        }
    }
    
    
    func resetProgress() {
        
        innerCurrentProgress = 0
        outerCurrentProgress = 0
        updateOuterProgress(0)
        updateInnerProgress(0)
        
    }
    
    
    override func drawRect(rect: CGRect) {
        
        let center = CGPoint(x: bounds.width/2, y: bounds.height/2)
        let radius = bounds.width/2
        let strokeWidth = CGFloat(10)
        let startAtAngle = 3*π/2
        let endAtAngle = startAtAngle - 0.0000000001
        
        let outerCircle = UIBezierPath(arcCenter: center, radius: radius - strokeWidth/2-10, startAngle: startAtAngle, endAngle: endAtAngle, clockwise: true)
        
        let innerCircle = UIBezierPath(arcCenter: center, radius: radius - strokeWidth/2-30, startAngle: startAtAngle, endAngle: endAtAngle, clockwise: true)
        
        outerStrokeColor.setStroke()
        outerCircle.lineWidth = strokeWidth
        outerCircle.stroke()
        outerProgressLine.path = outerCircle.CGPath
        outerProgressLine.strokeColor = UIColor.greenColor().CGColor
        outerProgressLine.fillColor = UIColor.blackColor().CGColor
        outerProgressLine.lineWidth = 10
        outerProgressLine.lineCap = kCALineCapRound
        outerCurrentProgress = 0
        self.layer.addSublayer(outerProgressLine)
        
        
        innerStrokeColor.setStroke()
        innerCircle.lineWidth = strokeWidth
        innerCircle.stroke()
        innerProgressLine.path = innerCircle.CGPath
        innerProgressLine.strokeColor = UIColor.redColor().CGColor
        innerProgressLine.fillColor = UIColor.blueColor().CGColor
        innerProgressLine.lineWidth = 10
        innerProgressLine.lineCap = kCALineCapRound
        innerCurrentProgress = 0
        self.layer.addSublayer(innerProgressLine)
        
    }
    
    func updateOuterProgress (newProgress: Double) {
        
        let animatedEnd = CABasicAnimation(keyPath: "strokeEnd")
        animatedEnd.duration = 0.5
        animatedEnd.fromValue = self.outerCurrentProgress
        animatedEnd.toValue = newProgress
        
        outerCurrentProgress = CGFloat(newProgress)
        outerProgressLine.addAnimation(animatedEnd, forKey: "animate stroke and end animation")
    }
    
    func updateInnerProgress (newProgress: Double) {
        
        let animatedEnd = CABasicAnimation(keyPath: "strokeEnd")
        animatedEnd.duration = 0.5
        animatedEnd.fromValue = self.innerCurrentProgress
        animatedEnd.toValue = newProgress
        
        innerCurrentProgress = CGFloat(newProgress)
        innerProgressLine.addAnimation(animatedEnd, forKey: "animate stroke and end animation")
        
    }
    
    
    
    
    
    
    
    
    
}
