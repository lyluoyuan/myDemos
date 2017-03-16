//
//  ViewController.swift
//  javaScriptDemo
//
//  Created by zm004 on 16/6/12.
//  Copyright © 2016年 zm004. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIWebViewDelegate{
    var webView : UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView = UIWebView(frame:view.bounds)
        view.addSubview(webView)
        webView.delegate = self
        let url = Bundle.main.url(forResource: "work", withExtension: "php")
        
//        let url = URL(string: "http://localhost")

//        webView.loadRequest(URLRequest(url: url!))
        NSURLConnection.sendAsynchronousRequest(URLRequest(url: url!), queue: OperationQueue.main) { (response, data, error) -> Void in
            
            
            print(response!.textEncodingName)
            print(response!.mimeType)
        }
        
//        let evaStr = try! String(contentsOf: Bundle.main.url(forResource: "test", withExtension: "js")!, encoding: String.Encoding.utf8)
//        webView.stringByEvaluatingJavaScript(from: evaStr)
        // Do any additional setup after loading the view, typically from a nib.
    }
//    func webViewDidFinishLoad(_ webView: UIWebView) {
//        webView.stringByEvaluatingJavaScript(from: "setImageClickFunction()")
//    }
//    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
//        let path = request.url?.absoluteString
//        print(path)
//        return true
//    }
}

