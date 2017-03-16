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
    let userDefaults = NSUserDefaults.standardUserDefaults()
    let imageUrlsStr = "imageUrlsStr"
    let fileManager = NSFileManager.defaultManager()
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
            self.cacheWebs.append(webUrl)
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
    func getCacheSize()->Float{
        var folderSize : Float = 0.0
        for d in cacheWebs{
            let request = NSMutableURLRequest(URL: NSURL(string: d)!)
            let cacheReponse = NSURLCache.sharedURLCache().cachedResponseForRequest(request)
            if let data = cacheReponse?.data{
                folderSize += Float(data.length)/1024.0/1024.0
            }
        }
        folderSize += Float(SDImageCache.sharedImageCache().getSize())/1024.0/1024.0
        return folderSize
    }
    func clearFile(){
        SDImageCache.sharedImageCache().clearDisk()
        NSURLCache.sharedURLCache().removeAllCachedResponses()
        cacheWebs.removeAll()
    }
    func loadLocalImageElseOnline(url:String, imageView:UIImageView, placeHolder:String){//加载沙盒图片，否则从网上下载
        
        
        let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first
        let imagePath = path?.stringByAppendingString("/images/")
        if !fileManager.fileExistsAtPath(imagePath!){
            do {
                try fileManager.createDirectoryAtPath(imagePath!, withIntermediateDirectories: true, attributes: nil)
            }catch{
                print(error)
            }
        }
        var imageUrls = [String:String]()
        if let urls = userDefaults.dictionaryForKey(imageUrlsStr) as? [String:String]{
            imageUrls = urls
            if let imageUrl = imageUrls[url]{
                let subPath = imagePath?.stringByAppendingString(imageUrl)
                imageView.image = UIImage(contentsOfFile: subPath!)
            }else{
                if let imageUrl = NSURL(string: url){
                    let request = NSMutableURLRequest(URL: imageUrl)
                    NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: { (response, data, error) -> Void in
                        imageView.image = UIImage(data: data!)
                        let value = "\(imageUrls.count)"
                        let subPath = imagePath?.stringByAppendingString(value)
                        let created = self.fileManager.createFileAtPath(subPath!, contents: data, attributes: nil)
                        if created{
                            data?.writeToFile(subPath!, atomically: true)
                            imageUrls[url] = "\(imageUrls.count)"
                            self.userDefaults.setObject(imageUrls, forKey: self.imageUrlsStr)
                        }
                    })
                }else{
                    imageView.image = UIImage(named: placeHolder)
                }
            }
        }else{
            if let imageUrl = NSURL(string: url){
                let request = NSMutableURLRequest(URL: imageUrl)
                NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: { (response, data, error) -> Void in
                    imageView.image = UIImage(data: data!)
                    let value = "\(imageUrls.count)"
                    let subPath = imagePath?.stringByAppendingString(value)
                    let created = self.fileManager.createFileAtPath(subPath!, contents: data, attributes: nil)
                    if created{
                        data?.writeToFile(subPath!, atomically: true)
                        imageUrls[url] = "\(imageUrls.count)"
                        self.userDefaults.setObject(imageUrls, forKey: self.imageUrlsStr)
                    }
                })
            }else{
                imageView.image = UIImage(named: placeHolder)
            }
        }
    }
    func getLocalImagesSize()->Float{
        var folderSize : Float = 0.0
        if let imageUrls = userDefaults.dictionaryForKey(imageUrlsStr) as? [String:String]{
            let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first
            let imagePath = path?.stringByAppendingString("/images/")
            for d in imageUrls{
                let subPath = imagePath?.stringByAppendingString(d.1)
                folderSize += fileSizeAtPath(subPath!)
            }
        }
        return folderSize
    }
    func fileSizeAtPath(filePath:String)->Float{
        if fileManager.fileExistsAtPath(filePath){
            do{
                let fileSize =  try fileManager.attributesOfItemAtPath(filePath)[NSFileSize] as! Float
                return fileSize
            }catch{
                print(error)
            }
        }
        return 0
    }
    func clearLocalImages(){
        
        if let imageUrls = userDefaults.dictionaryForKey(imageUrlsStr) as? [String:String]{
            let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first
            let imagePath = path?.stringByAppendingString("/images/")
            for d in imageUrls{
                let subPath = imagePath?.stringByAppendingString(d.1)
                do {
                    try fileManager.removeItemAtPath(subPath!)
                }catch{
                    print(error)
                }
            }
            userDefaults.removeObjectForKey(imageUrlsStr)
        }
    }
}
