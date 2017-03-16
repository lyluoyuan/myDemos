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
        
    }
    
    @IBAction func postAction(sender: UIButton) {
        var params = [String:AnyObject]()
        params["user_code"] = "17780628703"
        params["user_password"] = "654321"

        let ajax = Ajax(url: "common/authenticate", params: ["user_code":"17780628703","user_password":"654321","captcha":1111111111], vc: self)
        ajax.success = {json in
            self.resultView.text = json.json.description
            userDefaults.setObject(self.headerTextView.text, forKey: self.headerTextViewText)
        }
        ajax.post()
        
        
    }
    
    @IBAction func afterLoginAction(sender: UIButton) {
        let ajax = Ajax(url: "data/getActivityCustomerListUseFile?activity_id=\(41)", params: ["activity_id":41], vc: self)
        ajax.eFSuccess = {fArr in
            
        }
        ajax.eFGet()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
    }
    
}

