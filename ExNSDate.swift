//
//  ExNSDate.swift
//  MMProgressViewDemo
//
//  Created by zm004 on 16/3/30.
//  Copyright © 2016年 zm004. All rights reserved.
//

import UIKit

extension NSDate {
    func localDate()->NSDate{
        let zone = NSTimeZone.systemTimeZone()
        let interval = NSTimeInterval(zone.secondsFromGMT)        
        let localeDate = self.dateByAddingTimeInterval(interval)
        return localeDate
    }
    func stringValue(format:String = "yyyy-MM-dd HH:mm:ss")->String{
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = format
        let dateStr = dateFormatter.stringFromDate(self)
        return dateStr
    }
}
