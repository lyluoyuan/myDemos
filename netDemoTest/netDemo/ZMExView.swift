//
//  ZMExView.swift
//  ScoreManager
//
//  Created by qingyin02 on 15/4/20.
//  Copyright (c) 2015年 zm002. All rights reserved.
//

import UIKit

extension UIView {
    
    func addCenterLine(number:Int = 1) {
        let height = self.frame.size.height/CGFloat(number+1)
        for var i = 0; i < number; i++ {
            let view = UIView(frame: CGRectMake(0, height*CGFloat(i+1), self.frame.size.width, 1))
            view.backgroundColor = UIColor.hex( "#eeeeee")
            self.addSubview(view)
        }
    }
    
    func removeAllChildView() {
        for view in self.subviews {
            view.removeFromSuperview()
        }
    }
    
    func setBorder(color:UIColor) {
        self.layer.borderWidth = 1
        self.layer.borderColor = color.CGColor
    }
    
    func doCycle() {
        //        layer.borderWidth = 1
        layer.masksToBounds = false
        //        layer.borderColor = UIColor.blackColor().CGColor
        layer.cornerRadius = frame.height/2
        clipsToBounds = true
    }
    
    func setRadius(radius:CGFloat) {
        self.layer.cornerRadius=radius
        self.clipsToBounds = true
    }
    
    func addOneBorder(edge:UIRectEdge,color:UIColor,borderWidth:CGFloat = 0,borderMargin:CGFloat = 0,offset:CGFloat = 0) {
        let  border = CALayer()
        let w = CGRectGetWidth(self.frame),h = CGRectGetHeight(self.frame)
        switch edge {
        case UIRectEdge.Top:
            border.frame = CGRectMake(borderMargin, 0 + offset, w - borderMargin*2, borderWidth)
        case UIRectEdge.Bottom:
            border.frame = CGRectMake(borderMargin, h - borderWidth + offset, w - borderMargin*2, borderWidth)
        case UIRectEdge.Left:
            border.frame = CGRectMake(0+offset, borderMargin, borderWidth, h - borderMargin*2)
        case UIRectEdge.Right:
            border.frame = CGRectMake(w - borderWidth + offset, borderMargin, borderWidth, h - borderMargin*2)
        default:
            break
        }
        border.backgroundColor = color.CGColor
        border.name = "border\(edge)"
        self.layer.addSublayer(border)
        self.layer.setValue(border, forKey: "border\(edge)")
    }
    
    func updateOneBorder(edge:UIRectEdge,color:UIColor) {
        if let border = self.layer.valueForKey("border\(edge)") as? CALayer {
            border.backgroundColor = color.CGColor
        }
    }
    
//    func rotateView(number:CGFloat) {
//        UIView.beginAnimations("rotate", context: nil)
//        UIView.setAnimationDuration(0.3)
//        self.transform = CGAffineTransformMakeRotation(DegreesToRadians(45));// CGAffineTransformRotate(self.transform,DegreesToRadians(45*number))
//        UIView.commitAnimations()
        
//        [UIView beginAnimations:@"rotate" context:nil];
//        [UIView setAnimationDuration:0.5];
//        self.transform = CGAffineTransformMakeRotation(DegreesToRadians(90));
//        [UIView commitAnimations];
        
//        let rotateTransform = CGAffineTransformRotate(self.transform,CGFloat(M_PI/4)*number)
//        UIView.animateWithDuration(0.3, delay: 0, options:UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
//            self.transform = CGAffineTransformMakeRotation(DegreesToRadians(45))
//        }) { (finished) -> Void in
//            
//        }
//        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
//        rotationAnimation.toValue = M_PI/4 * Double(number)
//        rotationAnimation.duration = 0.3
//        rotationAnimation.autoreverses = true
//        rotationAnimation.repeatCount = 1
//        rotationAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
//        self.layer.addAnimation(rotationAnimation, forKey: "rotationAnimation")
//    }
    
    func addGestureTapAction(actionName:String,target:AnyObject) {
        let tapGesture = UITapGestureRecognizer(target: target, action: Selector(actionName))
        self.userInteractionEnabled = true
        self.addGestureRecognizer(tapGesture)
    }
    func setShape(shape : CGPathRef){
        if let shapeF : CGPathRef? = shape{
            //            let maskLayer = layer
            //            maskLayer.shadowPath = shapeF
            let maskLayer = CAShapeLayer(layer: layer)
            
            maskLayer.path = shapeF
            self.layer.mask = maskLayer
            
        }else{
            self.layer.mask = nil
        }
    }
    
}
extension UIBezierPath{
    class func makePoint(originalFrame : CGRect, length : CGFloat)-> UIBezierPath{
        let rect = originalFrame;
        let bezierPath = UIBezierPath()
        
        bezierPath.moveToPoint(CGPointMake(0, 0))
        bezierPath.addLineToPoint(CGPointMake(rect.width, 0))
        bezierPath.addLineToPoint(CGPointMake(rect.width, rect.height-length))
        bezierPath.addLineToPoint(CGPointMake(rect.width/2+length, rect.height-length))
        bezierPath.addLineToPoint(CGPointMake(rect.width/2, rect.height))
        bezierPath.addLineToPoint(CGPointMake(rect.width/2-length, rect.height-length))
        bezierPath.addLineToPoint(CGPointMake(0, rect.height-length))
        bezierPath.addLineToPoint(CGPointMake(0, 0))
        bezierPath.closePath()
        return bezierPath;
    }
    
    class func makeUpPoint(originalFrame : CGRect, length : CGFloat)-> UIBezierPath{
        let rect = originalFrame;
        let bezierPath = UIBezierPath()
        
        bezierPath.moveToPoint(CGPointMake(0, length))
        bezierPath.addLineToPoint(CGPointMake(rect.width/2-length, length))
        bezierPath.addLineToPoint(CGPointMake(rect.width/2, 0))
        bezierPath.addLineToPoint(CGPointMake(rect.width/2+length, length))
        bezierPath.addLineToPoint(CGPointMake(rect.width, length))
        bezierPath.addLineToPoint(CGPointMake(rect.width, rect.height))
        bezierPath.addLineToPoint(CGPointMake(0, rect.height))
        bezierPath.addLineToPoint(CGPointMake(0, length))
        bezierPath.closePath()
        return bezierPath;
    }
}