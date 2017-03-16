//
//  LYCache.swift
//  lenovoManager
//
//  Created by zm004 on 16/3/22.
//  Copyright © 2016年 zm004. All rights reserved.
//

import UIKit

class LYCache: NSObject {
    var cacheWebs = [String]()
    let cacheWebsStr = "cacheWebStrs"
//    let userDefaults = NSUserDefaults.standardUserDefaults()
    class func sharedCache() ->LYCache {
        struct Singleton {
            static var predicate : dispatch_once_t = 0
            static var instance : LYCache? = nil
        }
        dispatch_once(&Singleton.predicate, {
            Singleton.instance = LYCache()
        })
        return Singleton.instance!
    }
    func loadWebViewOnline(webUrl:String, webView:UIWebView) {
        if let url = NSURL(string: webUrl){

        let request = NSMutableURLRequest(URL: url)
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response, data, error) -> Void in
                if error == nil{
                    webView.loadData(data!, MIMEType: response!.MIMEType!, textEncodingName: response!.textEncodingName!, baseURL: NSURL(string: webUrl)!)
                    let cacheResponse = NSCachedURLResponse(response: response!, data: data!)
                    NSURLCache.sharedURLCache().storeCachedResponse(cacheResponse, forRequest: request)
                    if !self.cacheWebs.contains(webUrl){
                        self.cacheWebs.append(webUrl)
                    }
                }
            }
        }
    }
//    func getSubStringForUrl(webUrl:String, startStr : String, endStr : String)->String{
//        if let url = NSURL(string: webUrl){
//            do{
//                let wholeStr = try NSString(contentsOfURL: url, encoding: NSUTF8StringEncoding)
//                print(wholeStr)
//                let rangeOfStr = "img src=\""
//                let imageStartRange = wholeStr.rangeOfString(rangeOfStr)
//                let imageStartStr = NSMutableString(string: wholeStr.substringFromIndex(imageStartRange.location+imageStartRange.length))
//                let endOfStr = ".jpg"
//                let imageEndRange = imageStartStr.rangeOfString(endOfStr)
//                let imageEndStr = NSMutableString(string: imageStartStr.substringToIndex(imageEndRange.location+imageEndRange.length))             
//                return imageEndStr as String
//            }catch{
//                print(error)
//            }
//        }
//        return ""
//    }
    func loadWebView(webUrl:String, webView:UIWebView) {
        
        if cacheWebs.contains(webUrl){
            let request = NSMutableURLRequest(URL: NSURL(string: webUrl)!)
            if let cacheReponse = NSURLCache.sharedURLCache().cachedResponseForRequest(request){
                webView.loadData((cacheReponse.data), MIMEType: (cacheReponse.response.MIMEType)!, textEncodingName: cacheReponse.response.textEncodingName!, baseURL: NSURL(string: webUrl)!)
            }
        }else{
            loadWebViewOnline(webUrl, webView: webView)
        }
    }
    func getImage(imageUrl:String)->UIImage{
        if cacheWebs.contains(imageUrl){
            let request = NSMutableURLRequest(URL: NSURL(string: imageUrl)!)
            if let cacheReponse = NSURLCache.sharedURLCache().cachedResponseForRequest(request){
                if let newImage = UIImage(data: cacheReponse.data){
                    return newImage
                }
            }
        }else{
            return getImageOnline(imageUrl)
        }
        return UIImage(named: "defaultImage-lsdq")!
    }
    func getImageOnline(imageUrl:String)->UIImage{
        var image = UIImage(named: "defaultImage-lsdq")!
        if let url = NSURL(string: imageUrl){
            let request = NSMutableURLRequest(URL: url)
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response, data, error) -> Void in
                if error == nil{
                    let cacheResponse = NSCachedURLResponse(response: response!, data: data!)
                    NSURLCache.sharedURLCache().storeCachedResponse(cacheResponse, forRequest: request)
                    self.cacheWebs.append(imageUrl)
                    if let newImage = UIImage(data: data!){
                        image = newImage
                    }
                }else{
//                    zmprint(error)
                }
            }
        }
        return image
    }
//    func getCacheSize()->Float{
//        var folderSize : Float = 0.0
//        for d in cacheWebs{
//            let request = NSMutableURLRequest(URL: NSURL(string: d)!)
//            let cacheReponse = NSURLCache.sharedURLCache().cachedResponseForRequest(request)
//            if let data = cacheReponse?.data{
//                folderSize += Float(data.length)/1024.0/1024.0
//            }
//        }
//        folderSize += Float(SDImageCache.sharedImageCache().getSize())/1024.0/1024.0
//        return folderSize
//    }
//    func clearFile(){
//        SDImageCache.sharedImageCache().clearDisk()
//        NSURLCache.sharedURLCache().removeAllCachedResponses()
//        cacheWebs.removeAll()
//    }
}
