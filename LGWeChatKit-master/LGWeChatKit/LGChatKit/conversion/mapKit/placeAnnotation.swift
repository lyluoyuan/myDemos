//
//  placeAnnotation.swift
//  LGWeChatKit
//
//  Created by jamy on 10/29/15.
//  Copyright © 2015 jamy. All rights reserved.
//

import Foundation
import MapKit

class placeAnnotation: NSObject, MKAnnotation{
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
}// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com