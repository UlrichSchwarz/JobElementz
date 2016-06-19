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
    //008000
    //BA5F00
    let outerBackgroundStrokeColor = UIColor(red: 0x00/255, green: 0x40/255, blue: 0x00/255, alpha: 1.0)
    let outerStrokeColor = UIColor(red: 0x00/255, green: 0xff/255, blue: 0x00/255, alpha: 1.0)
    
    let innerBackgroundStrokeColor = UIColor(red: 0x7f/255, green: 0x47/255, blue: 0x00/255, alpha: 1.0)
    let innerStrokeColor = UIColor(red: 0xff/255, green: 0xb5/255, blue: 0x00/255, alpha: 1.0)
    
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
    
    private func gradientMask() -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        
        gradientLayer.locations = [0.0, 1.0]
        
        let colorTop: AnyObject = UIColor(red: 0x01/50, green: 0xa3/50, blue: 0xae/50, alpha: 1.0).CGColor
        let colorBottom: AnyObject = UIColor(red: 0x30/255, green: 0xc5/255, blue: 0xcb/255, alpha: 1.0).CGColor
        let arrayOfColors: [AnyObject] = [colorTop, colorBottom]
        gradientLayer.colors = arrayOfColors
        
        return gradientLayer
    }
    
    override func drawRect(rect: CGRect) {
        
        let center = CGPoint(x: bounds.width/2, y: bounds.height/2)
        let radius = bounds.width/2
        let strokeWidth = CGFloat(17)
        let backgroundStrokeWidth = CGFloat(17)
        let startAtAngle = 3*π/2
        let endAtAngle = startAtAngle - 0.0000000001
        
        let outerCircle = UIBezierPath(arcCenter: center, radius: radius - strokeWidth/2-10, startAngle: startAtAngle, endAngle: endAtAngle, clockwise: true)
        
        let outerBackgroundCircle = UIBezierPath(arcCenter: center, radius: radius - strokeWidth/2-10, startAngle: startAtAngle, endAngle: endAtAngle, clockwise: true)
        
        let innerCircle = UIBezierPath(arcCenter: center, radius: radius - strokeWidth/2-30, startAngle: startAtAngle, endAngle: endAtAngle, clockwise: true)
        
        let innerBackgroundCircle = UIBezierPath(arcCenter: center, radius: radius - strokeWidth/2-30, startAngle: startAtAngle, endAngle: endAtAngle, clockwise: true)
        
        //let gradientMaskLayer = gradientMask()
        
        
       // color.setStroke()
        
        
        outerStrokeColor.setStroke()
        outerCircle.lineWidth = strokeWidth
        outerCircle.stroke()
        
        outerBackgroundStrokeColor.setStroke()
        outerBackgroundCircle.lineWidth = backgroundStrokeWidth
        outerBackgroundCircle.stroke()
        
        outerProgressLine.path = outerCircle.CGPath
        outerProgressLine.strokeColor = outerStrokeColor.CGColor
        outerProgressLine.fillColor = UIColor.clearColor().CGColor
        outerProgressLine.lineWidth = 17
        outerProgressLine.lineCap = kCALineCapRound
        outerCurrentProgress = 0
        
        //gradientMaskLayer.mask = outerProgressLine
        
        self.layer.addSublayer(outerProgressLine)
        
        
        
        innerStrokeColor.setStroke()
        innerCircle.lineWidth = strokeWidth
        innerCircle.stroke()
        
        innerBackgroundStrokeColor.setStroke()
        innerBackgroundCircle.lineWidth = backgroundStrokeWidth
        innerBackgroundCircle.stroke()
        
        innerProgressLine.path = innerCircle.CGPath
        innerProgressLine.strokeColor = innerStrokeColor.CGColor
        innerProgressLine.fillColor = UIColor.clearColor().CGColor
        innerProgressLine.lineWidth = 17
        innerProgressLine.lineCap = kCALineCapRound
        innerCurrentProgress = 0
        self.layer.addSublayer(innerProgressLine)
        
        //self.layer.addSublayer(gradientMaskLayer)
        
        
        
        
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
