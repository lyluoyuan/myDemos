//
//  PieChartView.swift
//  netDemo
//
//  Created by zm004 on 16/5/12.
//  Copyright © 2016年 zm004. All rights reserved.
//

import UIKit

class PieChartView: UIView {
    var contentSpace : CGFloat = 70
    var innerCenter : CGPoint!
    var displayAnimation = true
    var descriptionLabels = [UILabel]()
    var lines = [UIView]()
    func drawPieChart(pieItems:[PieItem]){
        let realSize = frame.size
//        let minSide = [realSize.height,realSize.width].minElement()!
        innerCenter = CGPointMake(realSize.width/2,realSize.height/2)
        let pieWidth = realSize.width-2*contentSpace
        //圆
        let pieLayer = newCircleLayerWithRadius(pieWidth/4, borderWidth: pieWidth/2, fillColor: UIColor.clearColor(), borderColor: UIColor.clearColor(), startPercentage: 0, endPercentage: 1)
        self.layer.addSublayer(pieLayer)
        //扇形
        var currentPercentage : CGFloat = 0
        for (_,value) in pieItems.enumerate(){
            let endPercentage = currentPercentage + value.value
            let segmentPieLayer = newCircleLayerWithRadius(pieWidth/4, borderWidth: pieWidth/2, fillColor: UIColor.clearColor(), borderColor: value.color, startPercentage: currentPercentage, endPercentage: endPercentage)
            pieLayer.addSublayer(segmentPieLayer)
            
            //对应文字和折线
            let label = UILabel()
            label.numberOfLines = 0
            label.textAlignment = .Center
            label.text = "\(value.itemDescription)\n\(value.value)"
            label.font = UIFont.systemFontOfSize(13)
            label.sizeToFit()
            let centerAngle = CGFloat(-M_PI_2)+(currentPercentage+value.value/2)*CGFloat(2*M_PI)
            if value.value > 0.1{
                label.textColor = UIColor.whiteColor()
                label.center = CGPointMake(innerCenter.x+cos(centerAngle)*pieWidth/4, innerCenter.y+sin(centerAngle)*pieWidth/4)
            }else if value.value >= 0 && value.value <= 0.1{
                label.textColor = UIColor.blackColor()
                label.center = CGPointMake(innerCenter.x+cos(centerAngle)*(pieWidth*3/4-10), innerCenter.y+sin(centerAngle)*(pieWidth*3/4-10))
                //折线
                let line = UIView()
                line.frame.size = CGSizeMake(pieWidth/5, 1)
                line.backgroundColor = UIColor.blackColor()
                line.center = CGPointMake(innerCenter.x+cos(centerAngle)*pieWidth/2, innerCenter.y+sin(centerAngle)*pieWidth/2)
                line.transform = CGAffineTransformMakeRotation(centerAngle)
                self.addSubview(line)
                line.hidden = true
                lines.append(line)
            }
            self.addSubview(label)
            label.hidden = true
            descriptionLabels.append(label)
            currentPercentage = endPercentage
        }
        //蒙板
        let maskLayer = newCircleLayerWithRadius(pieWidth/4, borderWidth: pieWidth/2, fillColor: UIColor.clearColor(), borderColor: UIColor.blackColor(), startPercentage: 0, endPercentage: 1)
        pieLayer.mask = maskLayer
        //动画
        if displayAnimation{
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.duration  = 1
            animation.fromValue = 0
            animation.toValue   = 1
            animation.delegate  = self
            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            animation.removedOnCompletion = true
            pieLayer.mask?.addAnimation(animation, forKey: "circleAnimation")
        }
    }
    func newCircleLayerWithRadius(radius:CGFloat,borderWidth:CGFloat,fillColor:UIColor,borderColor:UIColor,startPercentage:CGFloat,endPercentage:CGFloat)->CAShapeLayer{
        let circle = CAShapeLayer()
        let path = UIBezierPath(arcCenter: innerCenter, radius: radius, startAngle: CGFloat(-M_PI_2), endAngle: CGFloat(M_PI_2 * 3), clockwise: true)
        circle.fillColor = fillColor.CGColor
        circle.strokeColor = borderColor.CGColor
        circle.strokeStart = startPercentage
        circle.strokeEnd = endPercentage
        circle.lineWidth = borderWidth
        circle.path = path.CGPath
        return circle
    }
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        for d in descriptionLabels{
            d.hidden = false
        }
        for i in lines{
            i.hidden = false
        }
    }
}
class PieItem : NSObject{
    var color : UIColor!
    var itemDescription : String!
    var value : CGFloat!
    init(color:UIColor, description : String, value : CGFloat) {
        super.init()
        self.color = color
        self.itemDescription = description
        self.value = value
    }
}