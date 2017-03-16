//
//  LineAndBarChartView.swift
//  netDemo
//
//  Created by zm004 on 16/5/12.
//  Copyright © 2016年 zm004. All rights reserved.
//

import UIKit

class LineAndBarChartView: UIView {
    var xTitle = ""
    
    var yLabelWidth : CGFloat = 50
    var xLabelHeight : CGFloat = 20
    var dataViewEmptySpace : CGFloat = 50
    var numberOfYSements = 5
    var spaceToMargin : CGFloat = 5
    
    var lineAndBarItems : [LineAndBarItem]!
    var currentSelectedPointIndex = 0
    
    var rateColor : UIColor!
    var wholeAccountColor : UIColor!
    var activityAccountColor : UIColor!
    
    var pointViewCenterPoints : [CGPoint]!
    var xAxisYOffset : CGFloat!
    var yValueMax : Int!
    var allLabels = [UILabel]()
    func drawLinesAndBars(items : [LineAndBarItem],rateColor:UIColor,wholeAccountColor:UIColor,activityAccountColor:UIColor){
        lineAndBarItems = items
        self.rateColor = rateColor
        self.wholeAccountColor = wholeAccountColor
        self.activityAccountColor = activityAccountColor
        currentSelectedPointIndex = lineAndBarItems.count - 1
        setupChartAndDrawLines()
        drawBars()
    }
    func drawBars(){
        for (index,d) in lineAndBarItems.enumerate(){
            barAnimation(index, count: d.activityAccount, xOffset: -10, color : activityAccountColor)
            barAnimation(index, count: d.wholeAccount, xOffset: 10, color: wholeAccountColor)
        }
    }
    func barAnimation(index:Int,count:Int,xOffset:CGFloat, color : UIColor){
        let activityBarPath = UIBezierPath()
        activityBarPath.lineWidth = 2
        activityBarPath.lineCapStyle = .Square
        activityBarPath.lineJoinStyle = .Round
        var pathYEnd : CGFloat = 0
        if index == currentSelectedPointIndex{
            activityBarPath.moveToPoint(CGPointMake(pointViewCenterPoints[index].x+xOffset, xAxisYOffset-3))
            pathYEnd = xAxisYOffset-CGFloat(count)/CGFloat(yValueMax)*(xAxisYOffset-spaceToMargin-dataViewEmptySpace)-3
        }else{
            activityBarPath.moveToPoint(CGPointMake(pointViewCenterPoints[index].x+xOffset, xAxisYOffset-2.5))
            pathYEnd = xAxisYOffset-CGFloat(count)/CGFloat(yValueMax)*(xAxisYOffset-spaceToMargin-dataViewEmptySpace)-2.5
        }
        activityBarPath.addLineToPoint(CGPointMake(pointViewCenterPoints[index].x+xOffset, pathYEnd))
        let activityShapeLayer = CAShapeLayer()
        
        activityShapeLayer.lineCap = kCALineCapSquare
        activityShapeLayer.lineJoin = kCALineJoinBevel
        activityShapeLayer.fillColor = UIColor.clearColor().CGColor
        activityShapeLayer.strokeColor = color.CGColor
        activityShapeLayer.lineWidth = index == currentSelectedPointIndex ? 6 : 5
        activityShapeLayer.strokeEnd = 0
        
        self.layer.addSublayer(activityShapeLayer)
        activityShapeLayer.path = activityBarPath.CGPath
        let activityAnimation = CABasicAnimation(keyPath: "strokeEnd")
        activityAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        activityAnimation.duration  = 1.5
        activityAnimation.fromValue = 0
        activityAnimation.toValue   = 1
        activityAnimation.autoreverses = false
        activityAnimation.delegate = self
        activityShapeLayer.addAnimation(activityAnimation, forKey: "activityAnimation")
        activityShapeLayer.strokeEnd = 1
        
        let ball = UIView()
        ball.frame.size = index == currentSelectedPointIndex ? CGSizeMake(16, 16) : CGSizeMake(14, 14)
        ball.layer.cornerRadius = ball.frame.width/2
        ball.clipsToBounds = true
        ball.center = CGPointMake(pointViewCenterPoints[index].x+xOffset, xAxisYOffset-2.5)
        ball.backgroundColor = color
        self.addSubview(ball)
        let ballAnimation = CAKeyframeAnimation(keyPath: "position")
        ballAnimation.duration = 1.5
        ballAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        ballAnimation.path = activityBarPath.CGPath;
        ballAnimation.removedOnCompletion = false
        ballAnimation.fillMode = kCAFillModeForwards
        ball.layer.addAnimation(ballAnimation, forKey: "pathAnimation")
        //柱形图上的label
        let barLabel = UILabel()
        barLabel.font = UIFont.systemFontOfSize(11)
        barLabel.textColor = UIColor.blackColor()
        barLabel.text = "\(count)"
        barLabel.sizeToFit()
        barLabel.center = CGPointMake(pointViewCenterPoints[index].x+xOffset, pathYEnd-14)
        self.addSubview(barLabel)
        barLabel.hidden = true
        allLabels.append(barLabel)
    }
    func setupChartAndDrawLines(){
        var rateValues = [Int]()
        for d in lineAndBarItems{
            let rateValue = Int(Float(d.activityAccount)/Float(d.wholeAccount)*100)
            rateValues.append(rateValue)
        }
        currentSelectedPointIndex = self.lineAndBarItems.count-1
        let realSize = frame.size
        //x轴
        xAxisYOffset = realSize.height-xLabelHeight
        let path = UIBezierPath()
        path.moveToPoint(CGPointMake(yLabelWidth, xAxisYOffset))
        path.addLineToPoint(CGPointMake(realSize.width-spaceToMargin, xAxisYOffset))
        path.closePath()
        let arrowViewXShape = CAShapeLayer().getFromPath(path)
        self.layer.addSublayer(arrowViewXShape)
        //y轴
        path.moveToPoint(CGPointMake(yLabelWidth, xAxisYOffset))
        path.addLineToPoint(CGPointMake(yLabelWidth, spaceToMargin))
        path.closePath()
        self.layer.addSublayer(CAShapeLayer().getFromPath(path))
        //x轴头和轴头label
        let xSpace = (realSize.width-spaceToMargin-yLabelWidth-dataViewEmptySpace)/CGFloat(lineAndBarItems.count)
        path.moveToPoint(CGPointMake(realSize.width-spaceToMargin-8,xAxisYOffset-2))
        path.addLineToPoint(CGPointMake(realSize.width-spaceToMargin-8, xAxisYOffset+2))
        path.addLineToPoint(CGPointMake(realSize.width-spaceToMargin, xAxisYOffset))
        path.addLineToPoint(CGPointMake(realSize.width-spaceToMargin-8, xAxisYOffset-2))
        path.closePath()
        let xAxisHead = CAShapeLayer().getFromPath(path)
        self.layer.addSublayer(xAxisHead)
        let xHeadLabel = UILabel(frame: CGRectMake(realSize.width-spaceToMargin-16-xSpace/2,xAxisYOffset,xSpace,xLabelHeight))
        xHeadLabel.textColor = UIColor.darkGrayColor()
        xHeadLabel.textAlignment = .Center
        xHeadLabel.font = UIFont.systemFontOfSize(13)
        xHeadLabel.text = "(\(xTitle))"
        self.addSubview(xHeadLabel)
        //y轴头和y轴头label
        let ySpace = (xAxisYOffset-spaceToMargin-dataViewEmptySpace)/CGFloat(numberOfYSements)
        path.moveToPoint(CGPointMake(yLabelWidth-2,spaceToMargin+8))
        path.addLineToPoint(CGPointMake(yLabelWidth+2, spaceToMargin+8))
        path.addLineToPoint(CGPointMake(yLabelWidth, spaceToMargin))
        path.addLineToPoint(CGPointMake(yLabelWidth-2,spaceToMargin+8))
        path.closePath()
        self.layer.addSublayer(CAShapeLayer().getFromPath(path))
        let yHeadLabel = UILabel(frame: CGRectMake(0,spaceToMargin+10-ySpace/2,yLabelWidth-3,ySpace))
        yHeadLabel.textColor = UIColor.darkGrayColor()
        yHeadLabel.textAlignment = .Right
        yHeadLabel.font = UIFont.systemFontOfSize(13)
        yHeadLabel.text = "(户)"
        self.addSubview(yHeadLabel)
        //yLabel
        var wholeAccount = [Int]()
        for d in lineAndBarItems{
            wholeAccount.append(d.wholeAccount)
        }
        yValueMax = wholeAccount.maxElement()
        //        let yValueMin = yValues.minElement()
        //        let yRange = yValueMax!-yValueMin!
        yValueMax = yValueMax!*5/4
        for index in 0..<numberOfYSements{
            let lineY = xAxisYOffset-ySpace*CGFloat(index+1)
            let yLabel = UILabel(frame: CGRectMake(0,lineY-ySpace/2,yLabelWidth-3,ySpace))
            yLabel.textColor = UIColor.darkGrayColor()
            yLabel.textAlignment = .Right
            yLabel.font = UIFont.systemFontOfSize(13)
            let formatter = NSNumberFormatter()
            formatter.numberStyle = .DecimalStyle
            yLabel.text = "\(formatter.stringFromNumber(Int(yValueMax!*(index+1)/5))!)"
            self.addSubview(yLabel)
        }
        //原点label
        let zeroLabel = UILabel(frame: CGRectMake(0,xAxisYOffset-ySpace/2,yLabelWidth-3,ySpace))
        zeroLabel.textColor = UIColor.darkGrayColor()
        zeroLabel.textAlignment = .Right
        zeroLabel.font = UIFont.systemFontOfSize(13)
        zeroLabel.text = "0"
        self.addSubview(zeroLabel)
        //rate的数据中心点
        let minRate = rateValues.minElement()!
        let maxRate = rateValues.maxElement()!
        let rateRange = CGFloat(maxRate - minRate)
        pointViewCenterPoints = [CGPoint]()//数据点的中心点
        for (index,value) in rateValues.enumerate(){
            let lineX = CGFloat(index+1)*xSpace+yLabelWidth
            let jointPoint = CGPointMake(lineX, xAxisYOffset-CGFloat(value-minRate)/rateRange*ySpace-4*ySpace-30)
            pointViewCenterPoints.append(jointPoint)
        }
        //xLabel
        for (index,value) in lineAndBarItems.enumerate(){
            let lineX = pointViewCenterPoints[index].x
            let xLabel = UILabel(frame: CGRectMake(lineX-xSpace/2,xAxisYOffset,xSpace,xLabelHeight))
            xLabel.textColor = UIColor.darkGrayColor()
            xLabel.textAlignment = .Center
            xLabel.font = UIFont.systemFontOfSize(13)
            xLabel.text = value.dateStr
            self.addSubview(xLabel)
        }
        //连线动画
        let progressline = UIBezierPath()
        //        progressline.moveToPoint(pointViewCenterPoints[0])
        progressline.lineWidth = 2
        progressline.lineCapStyle = .Round
        progressline.lineJoinStyle = .Round
        for (index,d) in pointViewCenterPoints.enumerate(){
            if index+1 < pointViewCenterPoints.count{
                let (start,end) = caculateJointForTwoPoint(d, point2: pointViewCenterPoints[index+1])
                progressline.moveToPoint(start)
                progressline.addLineToPoint(end)
            }
        }
        let chartLine = CAShapeLayer()
        chartLine.lineCap = kCALineCapRound
        chartLine.lineJoin = kCALineJoinBevel
        chartLine.fillColor = UIColor.clearColor().CGColor
        chartLine.strokeColor = rateColor.CGColor
        chartLine.lineWidth = 2.0
        chartLine.strokeEnd = 0.0
        self.layer.addSublayer(chartLine)
        chartLine.path = progressline.CGPath
        let lineAnimation = CABasicAnimation(keyPath: "strokeEnd")
        lineAnimation.duration = 1.5
        lineAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        lineAnimation.fromValue = 0
        lineAnimation.toValue = 1
        lineAnimation.autoreverses = false
        chartLine.addAnimation(lineAnimation, forKey: "strokeEndAnimation")
        chartLine.strokeEnd = 1
        //画rate数据点
        for (index,d) in pointViewCenterPoints.enumerate(){
            let ratePointView = UIView()
            ratePointView.frame.size = CGSizeMake(9, 9)
            ratePointView.center = d
            ratePointView.backgroundColor = UIColor.clearColor()
            ratePointView.layer.borderColor = rateColor.CGColor
            ratePointView.layer.borderWidth = 3
            ratePointView.layer.cornerRadius = ratePointView.frame.width/2
            ratePointView.clipsToBounds = true
            self.addSubview(ratePointView)
            //数据点上的label
            let ratePointLabel = UILabel()
            ratePointLabel.textColor = UIColor.blackColor()
            ratePointLabel.textAlignment = .Center
            ratePointLabel.text = "\(rateValues[index])%"
            ratePointLabel.font = UIFont.systemFontOfSize(11)
            ratePointLabel.sizeToFit()
            ratePointLabel.center = CGPointMake(d.x, d.y-10)
            ratePointLabel.hidden = true
            self.addSubview(ratePointLabel)
            allLabels.append(ratePointLabel)
        }
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        for d in allLabels{
            d.hidden = false
        }
    }
}
class LineAndBarItem: NSObject {
    var activityAccount : Int!
    var wholeAccount : Int!
    var dateStr : String!
    init(dateStr:String ,activityAccount : Int, wholeAccount : Int) {
        super.init()
        self.activityAccount = activityAccount
        self.wholeAccount = wholeAccount
        self.dateStr = dateStr
    }
}
