//
//  ViewController.swift
//  MMProgressViewDemo
//
//  Created by zm004 on 16/3/23.
//  Copyright © 2016年 zm004. All rights reserved.
//

import UIKit
import CoreGraphics
class ViewController: UIViewController,EasyTipViewDelegate ,JTCalendarDelegate{
    var todayDate : NSDate!
    var maxDate : NSDate!
    var minDate : NSDate!
    var dateSelected : NSDate!
    @IBOutlet weak var verticalCalendar : JTVerticalCalendarView!
    @IBOutlet weak var weekDayView : JTCalendarWeekDayView!
    
    var tipShow = false
    var calendarManager : JTCalendarManager!
    @IBOutlet weak var calender: JTHorizontalCalendarView!
    
    @IBOutlet weak var menuView: JTCalendarMenuView!
    @IBAction func hudAction(sender: UIButton) {
        MMProgressHUD.sharedHUD().overlayMode = .Gradient
        MMProgressHUD.setPresentationStyle(.Fade)
        
        MMProgressHUD.showWithTitle("long", status: "hold", confirmationMessage: "cancel?") { () -> Void in //超时取消
        }

        MMProgressHUD.show()

//        var preferences = EasyTipView.Preferences()
//        preferences.drawing.font = UIFont(name: "Futura-Medium", size: 13)!
//        preferences.drawing.foregroundColor = UIColor.whiteColor()
//        preferences.drawing.backgroundColor = UIColor(hue:0.46, saturation:0.99, brightness:0.6, alpha:1)
//        preferences.drawing.arrowPosition = EasyTipView.ArrowPosition.Bottom
//        EasyTipView.globalPreferences = preferences
//        
//        tipShow = !tipShow
//        
//        if tipShow{
//            let ev = EasyTipView(text: "Tip view inside the navigation controller's view. Tap to dismiss!", preferences : preferences, delegate : self)
//            ev.show(animated: true, forView: sender, withinSuperview: sender.superview)
//        }else{
//            
//        }
//        EasyTipView.show(forView: sender,
//            withinSuperview: self.navigationController?.view,
//            text: "Tip view inside the navigation controller's view. Tap to dismiss!",
//            preferences: preferences,
//            delegate: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        calendarManager = JTCalendarManager()
//        let dateFormatter = calendarManager.dateHelper.createDateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        let date1 = dateFormatter.dateFromString("2016-03-31 10:23:56")
//        print(date1!.localDate())
        
//        print(NSDate().stringValue())
//        
////        calendarManager = JTCalendarManager()
//        calendarManager.delegate = self
//        todayDate = NSDate()
//        minDate = calendarManager.dateHelper.addToDate(todayDate, months: -5)
//        maxDate = calendarManager.dateHelper.addToDate(todayDate, months: 5)
//        calendarManager.menuView = menuView
//        calendarManager.contentView = verticalCalendar
//        calendarManager.setDate(NSDate())
//        
//        calendarManager.settings.pageViewHaveWeekDaysView = false
//        calendarManager.settings.pageViewNumberOfWeeks = 0
//        weekDayView.manager = calendarManager
//        weekDayView.reload()
        // Do any additional setup after loading the view, typically from a nib.
    }
    func calendar(calendar: JTCalendarManager!, didTouchDayView dayView: UIView!) {
        let day = dayView as! JTCalendarDayView
        dateSelected = day.date
        day.circleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1)
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            day.circleView.transform = CGAffineTransformIdentity
            }, completion: nil)
        //lymark
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func easyTipViewDidDismiss(tipView: EasyTipView) {
        print("\(tipView) did dismiss!")
    }
    func calendar(calendar: JTCalendarManager!, prepareDayView dayView: UIView!) {
        let day = dayView as! JTCalendarDayView
        if calendarManager.dateHelper.date(NSDate(), isTheSameDayThan: day.date){
            day.circleView.hidden = false
            day.circleView.backgroundColor = UIColor.blueColor()
            day.dotView.backgroundColor = UIColor.whiteColor()
            day.textLabel.textColor = UIColor.whiteColor()
        }else if !calendarManager.dateHelper.date(calender.date, isTheSameMonthThan: day.date){
            day.circleView.hidden = true
            day.dotView.backgroundColor = UIColor.redColor()
            day.textLabel.textColor = UIColor.lightGrayColor()
        }else if dateSelected != nil && calendarManager.dateHelper.date(dateSelected, isTheSameDayThan: day.date){
            day.circleView.hidden = false
            day.circleView.backgroundColor = UIColor.redColor()
            day.dotView.backgroundColor = UIColor.whiteColor()
            day.textLabel.textColor = UIColor.whiteColor()
        }else{
            day.circleView.hidden = true
            day.dotView.backgroundColor = UIColor.redColor()
            day.textLabel.textColor = UIColor.blackColor()
        }
        day.dotView.hidden = false
    }
    func calendarBuildDayView(calendar: JTCalendarManager!) -> UIView! {
        let view = JTCalendarDayView()
        view.textLabel.font = UIFont(name: "Avenir-Light", size: 13)
        view.textLabel.textColor = UIColor.blackColor()
        return view
    }
    func calendar(calendar: JTCalendarManager!, canDisplayPageWithDate date: NSDate!) -> Bool {
        print("minDate: \(minDate)")
        print(calendarManager.dateHelper.date(date, isEqualOrAfter: minDate, andEqualOrBefore: maxDate))
        return calendarManager.dateHelper.date(date, isEqualOrAfter: minDate, andEqualOrBefore: maxDate)
    }
}
//extension MMHud{
//    func configureInitialDisplayAttributes(){
//
//        let blackColor = UIColor.greenColor().CGColor
//        self.titleLabel.textColor = UIColor.blackColor()
//        self.statusLabel.textColor = UIColor.blackColor()
//        self.activityIndicator.backgroundColor = UIColor.blackColor()
//        self.backgroundColor = UIColor.whiteColor()
//        self.layer.shadowColor  = blackColor
//        self.layer.shadowOpacity = 0.5
//        self.layer.shadowRadius = 15.0
//        self.layer.cornerRadius = 10.0
//        
//        self.autoresizingMask = [UIViewAutoresizing.FlexibleLeftMargin , UIViewAutoresizing.FlexibleRightMargin , UIViewAutoresizing.FlexibleTopMargin , UIViewAutoresizing.FlexibleBottomMargin]
//    }
//}

