//
//  ExtensionString.swift
//  netDemo
//
//  Created by zm004 on 16/5/3.
//  Copyright © 2016年 zm004. All rights reserved.
//

import UIKit

extension String {
    func changedToDic()->[String:String]{
        var dic = [String:String]()
        let splitedarray = self.explode(",")
        for d in splitedarray{
            let dArray = d.explode(":")
            dic[dArray.first!] = dArray.last!
        }
        return dic
    }
}
