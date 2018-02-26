//
//  TicTacButton.swift
//  Tic2Tac
//
//  Created by apple on 25/02/18.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit

class TicTacButton: UIButton {

    var circleLayer: CAShapeLayer = CAShapeLayer()
    var crossLayer: CAShapeLayer = CAShapeLayer()
    let buttonTintColor = UIColor(red: 0.7058823529, green: 0.2745098039, blue: 0.07843137255, alpha: 1.0)
    
    func drawCircle() {
        self.clear()
        
        print("Button Frame for circle = \(frame) --- origin.x:\(0) --- origin.y:\(0)")
        
        let circlePath = UIBezierPath()
        circlePath.move(to: CGPoint(x: 0.66875 * frame.width, y: 0.50369 * frame.height))
        circlePath.addCurve(to: CGPoint(x: 0.49018 * frame.width, y: 0.68835 * frame.height),
                            controlPoint1: CGPoint(x: 0.66875 * frame.width, y: 0.68835 * frame.height),
                            controlPoint2: CGPoint(x: 0.49018 * frame.width, y: 0.68835 * frame.height))
        circlePath.addCurve(to: CGPoint(x: 0.31161 * frame.width, y: 0.50369 * frame.height),
                            controlPoint1: CGPoint(x: 0.49018 * frame.width, y: 0.68835 * frame.height),
                            controlPoint2: CGPoint(x: 0.31161 * frame.width, y: 0.68835 * frame.height))
        circlePath.addCurve(to: CGPoint(x: 0.49018 * frame.width, y: 0.33324 * frame.height),
                            controlPoint1: CGPoint(x: 0.31161 * frame.width, y: 0.31903 * frame.height),
                            controlPoint2: CGPoint(x: 0.49018 * frame.width, y: 0.33324 * frame.height))
        circlePath.addCurve(to: CGPoint(x: 0.66875 * frame.width, y: 0.50369 * frame.height),
                            controlPoint1: CGPoint(x: 0.49018 * frame.width, y: 0.33324 * frame.height),
                            controlPoint2: CGPoint(x: 0.66875 * frame.width, y: 0.31903 * frame.height))
        circlePath.close()
        
        
        circlePath.move(to: CGPoint(x: 0.35625 * frame.width, y: 0.50537 * frame.height))
        
        circlePath.addCurve(to: CGPoint(x: 0.49018 * frame.width, y: 0.64574 * frame.height),
                            controlPoint1: CGPoint(x: 0.35625 * frame.width, y: 0.64574 * frame.height),
                            controlPoint2: CGPoint(x: 0.49018 * frame.width, y: 0.64574 * frame.height))
        circlePath.addCurve(to: CGPoint(x: 0.62411 * frame.width, y: 0.50537 * frame.height),
                            controlPoint1: CGPoint(x: 0.49018 * frame.width, y: 0.64574 * frame.height),
                            controlPoint2: CGPoint(x: 0.62411 * frame.width, y: 0.64574 * frame.height))
        circlePath.addCurve(to: CGPoint(x: 0.49018 * frame.width, y: 0.37579 * frame.height),
                            controlPoint1: CGPoint(x: 0.62411 * frame.width, y: 0.36499 * frame.height),
                            controlPoint2: CGPoint(x: 0.49018 * frame.width, y: 0.37579 * frame.height))
        circlePath.addCurve(to: CGPoint(x: 0.35625 * frame.width, y: 0.50537 * frame.height),
                            controlPoint1: CGPoint(x: 0.49018 * frame.width, y: 0.37579 * frame.height),
                            controlPoint2: CGPoint(x: 0.35625 * frame.width, y: 0.36499 * frame.height))
        circlePath.close()
        
        self.circleLayer = CAShapeLayer()
        self.circleLayer.path = circlePath.cgPath
        self.circleLayer.lineWidth = 5.0;
        self.circleLayer.fillColor = UIColor.clear.cgColor
        self.circleLayer.strokeColor = self.buttonTintColor.cgColor
        circleLayer.strokeEnd = 0.0
        self.layer.addSublayer(self.circleLayer)
        self.animateCircle(duration:0.5)
        
    }
    
    func animateCircle(duration: TimeInterval) {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = duration
        animation.fromValue = 0
        animation.toValue = 1
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        self.circleLayer.strokeEnd = 1.0
        self.circleLayer.add(animation, forKey: "animateCircle")
    }
    
    func drawCross() {
        self.clear()

        print("Button Frame for cross = \(frame)")
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 0.30833 * frame.width, y: 0.34167 * frame.height))
        
        bezierPath.addLine(to: CGPoint(x: 0.35833 * frame.width, y: 0.29167 * frame.height))
        bezierPath.addLine(to: CGPoint(x: 0.50833 * frame.width, y: 0.45833 * frame.height))
        bezierPath.addLine(to: CGPoint(x: 0.64167 * frame.width, y: 0.29167 * frame.height))
        bezierPath.addLine(to: CGPoint(x: 0.69167 * frame.width, y: 0.34167 * frame.height))
        bezierPath.addLine(to: CGPoint(x: 0.55833 * frame.width, y: 0.50833 * frame.height))
        bezierPath.addLine(to: CGPoint(x: 0.69167 * frame.width, y: 0.65833 * frame.height))
        bezierPath.addLine(to: CGPoint(x: 0.64167 * frame.width, y: 0.70833 * frame.height))
        bezierPath.addLine(to: CGPoint(x: 0.50833 * frame.width, y: 0.55833 * frame.height))
        bezierPath.addLine(to: CGPoint(x: 0.37500 * frame.width, y: 0.70833 * frame.height))
        bezierPath.addLine(to: CGPoint(x: 0.32500 * frame.width, y: 0.65833 * frame.height))
        bezierPath.addLine(to: CGPoint(x: 0.45833 * frame.width, y: 0.50833 * frame.height))
        bezierPath.addLine(to: CGPoint(x: 0.30833 * frame.width, y: 0.34167 * frame.height))
        bezierPath.close()
        
        self.crossLayer = CAShapeLayer()
        self.crossLayer.path = bezierPath.cgPath
        self.crossLayer.lineWidth = 6.0;
        self.crossLayer.fillColor = UIColor.clear.cgColor
        self.crossLayer.strokeColor = self.buttonTintColor.cgColor
        
        self.crossLayer.strokeEnd = 0.0
        //self.crossLayer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.layer.addSublayer(self.crossLayer)
        self.animateCross(duration:0.5)
        

    }
    
    
    func animateCross(duration: TimeInterval) {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = duration
        animation.fromValue = 0
        animation.toValue = 1
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        self.crossLayer.strokeEnd = 1.0
        self.crossLayer.add(animation, forKey: "animateCross")
    }
    
    func clear() {
        self.circleLayer.removeAllAnimations()
        self.crossLayer.removeAllAnimations()
        self.circleLayer.removeFromSuperlayer()
        self.crossLayer.removeFromSuperlayer()
    }

}
