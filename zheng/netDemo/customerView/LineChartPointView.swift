//
//  LineChartPointView.swift
//  netDemo
//
//  Created by zm004 on 16/5/10.
//  Copyright © 2016年 zm004. All rights reserved.
//

import UIKit

class LineChartPointView: UIView {
    var innerRadius : CGFloat = 2
    var pointColor : UIColor = chartGreenColor
//    override func drawRect(rect: CGRect) {
//        self.backgroundColor = UIColor.clearColor()
//        let context = UIGraphicsGetCurrentContext()
////        CGContextMoveToPoint(context, center.x+innerRadius, center.y)
//
////        CGContextSetStrokeColorWithColor(context, pointColor.CGColor)
////        CGContextSetFillColorWithColor(context, pointColor.CGColor)
////        CGContextSetLineWidth(context, 1)
////        CGContextAddArc(context, center.x, center.y, innerRadius, 0, CGFloat(M_PI*2.0), 0)
////        
////        CGContextStrokePath(context)
////        CGContextDrawPath(context, .FillStroke)
//        CGContextSetRGBFillColor (context,  1, 0, 0, 1.0)
//        CGContextSetRGBStrokeColor(context,1,1,1,1.0)
//        CGContextSetLineWidth(context, 1.0)
//        CGContextAddArc(context, 150, 30, 30, 0, CGFloat(2*M_PI), 0)
//        CGContextDrawPath(context, .Fill)
//    }

    func setupOuterLayer(){
        let path = UIBezierPath()
        path.addArcWithCenter(center, radius: innerRadius, startAngle: 0.0, endAngle: CGFloat(M_PI*2.0), clockwise: true)
        path.closePath()
        self.layer.addSublayer(CAShapeLayer().getFromPath(path, color: pointColor))
        
        self.layer.borderColor = pointColor.CGColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = frame.width/2
        self.clipsToBounds = true
    }
    
}
