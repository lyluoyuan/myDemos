//
//  ViewController.swift
//  textViewEmojiDemo
//
//  Created by zm004 on 16/4/25.
//  Copyright © 2016年 zm004. All rights reserved.
//

import UIKit

class ViewController: UIViewController,CustomEmojiViewDelegate{

    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var textTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        LYCache.sharedCache().loadWebView("http://t2016.lsdq.me/api_jian/article?id=5", webView: webView)
        // Do any additional setup after loading the view, typically from a nib.606
    }
    @IBAction func setEmoji(sender: UIButton) {
        textTextView.inputView = CustomEmojiView(textView: textTextView,delegate:self)
    }
    func CustomEmojiViewSendText(text: String) {
        print(text)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
    }

}

