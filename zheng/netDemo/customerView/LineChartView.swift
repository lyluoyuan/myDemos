//
//  LineChartView.swift
//  netDemo
//
//  Created by zm004 on 16/5/9.
//  Copyright © 2016年 zm004. All rights reserved.
//

import UIKit
protocol LineChartViewDelegate{
    func didSelectPointInLineChartView(index:Int)
}
class LineChartView: UIView {
    var xTitle = ""
    var yTitle = ""
    var yLabelWidth : CGFloat = 50
    var xLabelHeight : CGFloat = 20
    var dataViewEmptySpace : CGFloat = 50
    var numberOfYSements = 5
    var spaceToMargin : CGFloat = 5
    
    var xValues : [String]!
    var yValues : [Float]!
    var currentSelectedPointIndex = 0
    
    var allPointLabels = [UILabel]()
    
    var allPoints = [CGPoint]()
    
    var delegate:LineChartViewDelegate!
    func drawView(xValues:[String],yValues:[Float]){
        self.xValues = xValues
        self.yValues = yValues
        allPointLabels.removeAll()
        allPoints.removeAll()
        currentSelectedPointIndex = self.yValues.count-1
        
        let realSize = frame.size
        let xSpace = (realSize.width-spaceToMargin-yLabelWidth-dataViewEmptySpace)/CGFloat(xValues.count)
        
        let xAxisYOffset = realSize.height-xLabelHeight
        
        //画横线和yLabel
        var yValueMax = yValues.maxElement()!
        yValueMax = yValueMax*5/4
        let ySpace = (xAxisYOffset-spaceToMargin-dataViewEmptySpace)/CGFloat(numberOfYSements)
        for index in 0..<numberOfYSements{
            let linePath = UIBezierPath()
            let lineY = xAxisYOffset-ySpace*CGFloat(index+1)
            linePath.moveToPoint(CGPointMake(yLabelWidth, lineY))
            linePath.addLineToPoint(CGPointMake(realSize.width-spaceToMargin-dataViewEmptySpace,lineY))
            linePath.closePath()
            self.layer.addSublayer(CAShapeLayer().getFromPath(linePath,color:UIColor.lightGrayColor()))
            
            let yLabel = UILabel(frame: CGRectMake(0,lineY-ySpace/2,yLabelWidth-3,ySpace))
            yLabel.textColor = UIColor.darkGrayColor()
            yLabel.textAlignment = .Right
            yLabel.font = UIFont.systemFontOfSize(13)
            
            yLabel.text = "\(Int(yValueMax*Float(index+1)/5))"
            self.addSubview(yLabel)
        }
        //数据点的中心点
        var pointViewCenterPoints = [CGPoint]()
        for (index,_) in self.xValues.enumerate(){
            let lineX = CGFloat(index+1)*xSpace+yLabelWidth
            let jointPoint = CGPointMake(lineX, xAxisYOffset-(xAxisYOffset-spaceToMargin-dataViewEmptySpace)*CGFloat(yValues[index]/yValueMax))
            pointViewCenterPoints.append(jointPoint)
        }
        //画竖线和xLabel以及数据点 数据点上的label
        for (index,value) in self.xValues.enumerate(){
            //竖线
            let linePath = UIBezierPath()
            let lineX = pointViewCenterPoints[index].x
            linePath.moveToPoint(CGPointMake(lineX, xAxisYOffset))
            linePath.addLineToPoint(CGPointMake(lineX, spaceToMargin+dataViewEmptySpace))
            self.layer.addSublayer(CAShapeLayer().getFromPath(linePath,color:UIColor.lightGrayColor()))
            //xLabel
            let xLabel = UILabel(frame: CGRectMake(lineX-xSpace/2,xAxisYOffset,xSpace,xLabelHeight))
            xLabel.textColor = UIColor.darkGrayColor()
            xLabel.textAlignment = .Center
            xLabel.font = UIFont.systemFontOfSize(13)
            xLabel.text = value
            self.addSubview(xLabel)
            //数据点
            let pointView = LineChartPointView()
            pointView.backgroundColor = mainBgColor
            pointView.frame.size = CGSizeMake(10, 10)
            if index == currentSelectedPointIndex{
                pointView.frame.size = CGSizeMake(12, 12)
                pointView.pointColor = UIColor.hex("#399691")
                pointView.innerRadius = 3
            }
            pointView.setupOuterLayer()
            pointView.center = pointViewCenterPoints[index]
            self.addSubview(pointView)
            //数据点上的label
            let pointLabel = UILabel()
            pointLabel.backgroundColor = UIColor.clearColor()
            pointLabel.textAlignment = .Center
            pointLabel.frame.size = CGSizeMake(xSpace, 20)
            pointLabel.center = CGPointMake(lineX, pointView.center.y-10-3)
            pointLabel.text = "\(yValues[index])"
            if index != currentSelectedPointIndex{
                pointLabel.textColor = UIColor.blackColor()
                pointLabel.font = UIFont.boldSystemFontOfSize(10)
            }else{
                pointLabel.textColor = pointView.pointColor
                pointLabel.font = UIFont.boldSystemFontOfSize(11)
            }
            allPointLabels.append(pointLabel)
        }
        //原点label
        let zeroLabel = UILabel(frame: CGRectMake(0,xAxisYOffset-ySpace/2,yLabelWidth-3,ySpace))
        zeroLabel.textColor = UIColor.darkGrayColor()
        zeroLabel.textAlignment = .Right
        zeroLabel.font = UIFont.systemFontOfSize(13)
        zeroLabel.text = "0"
        self.addSubview(zeroLabel)
        
        //动画
        let aniView = UIView(frame: CGRectMake(yLabelWidth,spaceToMargin+dataViewEmptySpace,realSize.width-spaceToMargin-yLabelWidth,xAxisYOffset-spaceToMargin-dataViewEmptySpace))
        aniView.backgroundColor = mainBgColor
        self.addSubview(aniView)
        
        let rawLayer = createAniViewLayer(aniView)
        aniView.layer.addSublayer(rawLayer)
        let viewPoints = createPointView(aniView)
        //数据点的连线
        let connectPath = UIBezierPath()
        connectPath.moveToPoint(CGPointMake(0,aniView.frame.height))
        for d in viewPoints{
            connectPath.addLineToPoint(d)
        }
        let connectShapeLayer = CAShapeLayer()
        connectShapeLayer.path = connectPath.CGPath
        connectShapeLayer.strokeColor = chartGreenColor.CGColor
        connectShapeLayer.fillColor = UIColor.clearColor().CGColor
        connectShapeLayer.lineWidth = 2
        rawLayer.addSublayer(connectShapeLayer)
        //数据点下的区域
        let connectAreaLayer = CAShapeLayer()
        let connectAreaPath = connectPath.copy() as! UIBezierPath
        connectAreaPath.addLineToPoint(CGPointMake(pointViewCenterPoints.last!.x,xAxisYOffset))
        connectAreaPath.closePath()
        connectAreaLayer.path = connectAreaPath.CGPath
        let connectAreaColor = UIColor(color: UIColor.hex("#dde7e9"), alpha: 0.5)
        connectAreaLayer.strokeColor = connectAreaColor.CGColor
        connectAreaLayer.fillColor = connectAreaColor.CGColor
        connectAreaLayer.lineWidth = 1
        rawLayer.addSublayer(connectAreaLayer)
        
        let maskLayer = createAniViewLayer(aniView)
//        createPointView(aniView)
        
        aniView.layer.mask = maskLayer
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration  = 1.5
        animation.fromValue = 0
        animation.toValue   = 1
        animation.delegate  = self
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        animation.removedOnCompletion = true
        aniView.layer.mask!.addAnimation(animation, forKey: "maskAnimation")
        
        //x轴
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
        //y轴头和y轴头label
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
        yHeadLabel.text = "(\(yTitle))"
        self.addSubview(yHeadLabel)
        //x轴头和轴头label
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
        //点击数据点
        aniView.addGestureTapAction("tapAniViewAction:", target: self)
    }
    func tapAniViewAction(sender: UITapGestureRecognizer){
        let tapPoint = sender.locationInView(sender.view)
        let pathWidth = sender.view!.frame.width-dataViewEmptySpace
        let xSpace = pathWidth/CGFloat(xValues.count)
        var xRange = Int(tapPoint.x/xSpace-0.5)
        if xRange<0{
            xRange = 0
        }
        let yRange = abs(allPoints[xRange].y-tapPoint.y)
        if yRange < 50{
            delegate.didSelectPointInLineChartView(xRange)
        }
    }
    func createAniViewLayer(aniView:UIView)->CAShapeLayer{
        let rawLayer = CAShapeLayer()
        let rawPath = UIBezierPath()
        let pathWidth = aniView.frame.width-dataViewEmptySpace
        rawPath.moveToPoint(CGPointMake(0, aniView.frame.height/2))
        rawPath.addLineToPoint(CGPointMake(pathWidth,aniView.frame.height/2))
        rawLayer.strokeColor = mainBgColor.CGColor
        rawLayer.fillColor = UIColor.clearColor().CGColor
        rawLayer.lineWidth = aniView.frame.height
        rawLayer.path = rawPath.CGPath
        //横
        let ySpace = aniView.frame.height/CGFloat(numberOfYSements)
        let xSpace = pathWidth/CGFloat(xValues.count)
        for index in 0..<numberOfYSements{
            let lineXPath = UIBezierPath()
            lineXPath.moveToPoint(CGPointMake(0, ySpace*CGFloat(index+1)))
            lineXPath.addLineToPoint(CGPointMake(pathWidth, ySpace*CGFloat(index+1)))
            rawLayer.addSublayer(CAShapeLayer().getFromPath(lineXPath, color: UIColor.lightGrayColor()))
        }//竖
        for index in 0..<xValues.count{
            let lineYPath = UIBezierPath()
            lineYPath.moveToPoint(CGPointMake(xSpace*CGFloat(index+1), 0))
            lineYPath.addLineToPoint(CGPointMake(xSpace*CGFloat(index+1), aniView.frame.height))
            rawLayer.addSublayer(CAShapeLayer().getFromPath(lineYPath,color:UIColor.lightGrayColor()))
        }
        return rawLayer
    }
    //动画View中的数据点
    func createPointView(aniView:UIView)->[CGPoint]{
        let pathWidth = aniView.frame.width-dataViewEmptySpace
        let xSpace = pathWidth/CGFloat(xValues.count)
        var yValueMax = yValues.maxElement()!
        yValueMax = yValueMax*5/4
        if allPoints.isEmpty{
            var jointPoints = [CGPoint]()
            for (index,_) in self.xValues.enumerate(){
                let lineX = CGFloat(index+1)*xSpace
                let jointPoint = CGPointMake(lineX, aniView.frame.height*(1-CGFloat(yValues[index]/yValueMax)))
                jointPoints.append(jointPoint)
                allPoints = jointPoints
            }
        }
        for (index,d) in allPoints.enumerate(){
            let pointView = LineChartPointView()
            pointView.backgroundColor = mainBgColor
            pointView.frame.size = CGSizeMake(10, 10)
            if index == currentSelectedPointIndex{
                pointView.frame.size = CGSizeMake(12, 12)
                pointView.pointColor = UIColor.hex("#399691")
                pointView.innerRadius = 3
            }
            pointView.setupOuterLayer()
            pointView.center = d
            aniView.addSubview(pointView)
        }
        return allPoints
    }
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        for d in allPointLabels{
            self.addSubview(d)
        }
    }
}
