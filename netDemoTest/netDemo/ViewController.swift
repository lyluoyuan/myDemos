//
//  ViewController.swift
//  netDemo
//
//  Created by zm004 on 16/4/29.
//  Copyright © 2016年 zm004. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let headerTextViewText = "headerTextViewText"
    let urlTextViewText = "urlTextViewText"
    let paramsTextViewText = "paramsTextViewText"
    @IBOutlet weak var headerTextView: UITextView!
    @IBOutlet weak var urlTextView: UITextView!
    @IBOutlet weak var paramsTextView: UITextView!
    @IBOutlet weak var resultView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        var outCount : UInt32 = 0

        let properties = class_copyPropertyList(UITableViewCell.classForCoder(), &outCount)

        headerTextView.text = userDefaults.stringForKey(headerTextViewText)
        urlTextView.text = userDefaults.stringForKey(urlTextViewText)
        paramsTextView.text = userDefaults.stringForKey(paramsTextViewText)
//        headerTextView.text = "Appterminal:2,Appversion:\(getAppVersion()),Apptype:1"
//        urlTextView.text = "common/authenticate"
//        paramsTextView.text = "user_code:17780628703,user_password:654321"
    }
    
    @IBAction func postAction(sender: UIButton) {

//        params["user_code"] = "17780628703"
//        params["user_password"] = "654321"
//        common/authenticate
//        self.headerTextView.text = "Appterminal:2,Appversion:\(getAppVersion()),Apptype:1"
        
        let headers = self.headerTextView.text.changedToDic()
        print(headers.description)
        let params : [String:String]? = paramsTextView.text == "" ? nil : paramsTextView.text.changedToDic()
        let ajax = Ajax(url: urlTextView.text, params: params, vc: self)
        ajax.httpHeaders = headers
        ajax.success = {json in
            self.resultView.text = json.json.description
            userDefaults.setObject(self.headerTextView.text, forKey: self.headerTextViewText)
            userDefaults.setObject(self.urlTextView.text, forKey: self.urlTextViewText)
            userDefaults.setObject(self.paramsTextView.text, forKey: self.paramsTextViewText)
        }
        ajax.post()
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
    }
    
}

