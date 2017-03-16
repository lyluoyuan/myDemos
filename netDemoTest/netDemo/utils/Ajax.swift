//
//  Ajax.swift
//  eshangk-ios
//
//  Created by zm002 on 14/12/30.
//  Copyright (c) 2014年 zm002. All rights reserved.
//

//git submodule add https://github.com/Alamofire/Alamofire.git

// warning defaultHTTPHeaders()
//"app_terminal":"ios "+NSProcessInfo().operatingSystemVersionString,
// "app_version":NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleShortVersionString") as String,

import UIKit
//import Alamofire

#if DEBUG
    //    let BASE_HOST = "http://172.16.7.10/"
    //    let BASE_HOST = "http://192.168.1.107/"
    //    let BASE_HOST = "http://192.168.10.100/"
//let BASE_HOST = "http://192.168.8.113/" //"http://t.lsdq.me/"
//        let BASE_HOST = "http://t.lsdq.me/"
    let BASE_HOST = "http://www.lvsediqiu.com/"
#else
        let BASE_HOST = "http://www.lvsediqiu.com/"
//let BASE_HOST = "http://t.lsdq.me/"
    //    let BASE_HOST = "http://192.168.10.103/"
#endif

//let BASE_HOST = "http://www.lvsediqiu.com/"

//let BASE_HOST = "http://www.lvsediqiu.com/"
//let BASE_HOST = "http://192.168.1.100/"
//let BASE_HOST = "http://my.www.lvsediqiu.com/"
let HOST = BASE_HOST+"api_app/"


var requestCount = 0
class Ajax {
    
    var params = [String:AnyObject]()
    
    var url:String!
    
    var hud = true
    var hudMsg = ""
    var autoHideHud = true
    
    var success:((json:Zjson) -> Void)!
    var failure:((json:Zjson) -> Void)!
    var error:((error:NSError) -> Void)!
    var callback:((json:Zjson?) -> Void)!
    
    var delegateVC:UIViewController!
    var httpHeaders : [String:String]!
    init(url:String,params:[String:AnyObject]?,vc:UIViewController) {
        self.url = HOST+url
        self.delegateVC = vc
        if(params != nil) {
            self.params = params!
        }
        
    }
//    Optional([Appversion: 1.0, Accept-Encoding: gzip;q=1.0,compress;q=0.5, User-Agent: netDemo/com.zmaitech.netDemo (1; OS Version 9.2 (Build 13C75)), Appterminal: 2, Apptype: 1, Accept-Language: zh-Hans-CN;q=1.0])
//    FAILURE: Error Domain=NSURLErrorDomain Code=-999 "已取消" UserInfo={NSErrorFailingURLKey=http://www.lvsediqiu.com/api_app/common/authenticate, NSLocalizedDescription=已取消, NSErrorFailingURLStringKey=http://www.lvsediqiu.com/api_app/common/authenticate}
    
//    class var sharedManager: Manager {
//        struct Singleton {
//            static var configuration: NSURLSessionConfiguration = {
//                var headers = Manager.sharedInstance.session.configuration.HTTPAdditionalHeaders ?? [:]
//                var configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
//                //                headers["app-terminal"] = "ios " + UIDevice.currentDevice().systemName + " " + UIDevice.currentDevice().systemVersion
//                headers["Appterminal"] = "2"
//                headers["Appversion"] = getAppVersion()
//                headers["Apptype"] = "1"
//                //                headers["app-version"] = getAppVersion()
//                configuration.HTTPAdditionalHeaders = headers
//                
//                return configuration
//            }()
//
//            static let instance = Manager(configuration: configuration)
//        }
//        
//        return Singleton.instance
        
//        let configuration: NSURLSessionConfiguration = {
//            var headers = Manager.sharedInstance.session.configuration.HTTPAdditionalHeaders ?? [:]
//            let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
//            //                headers["app-terminal"] = "ios " + UIDevice.currentDevice().systemName + " " + UIDevice.currentDevice().systemVersion
//            headers["Appterminal"] = "2"
//            headers["Appversion"] = getAppVersion()
//            headers["Apptype"] = "1"
//            //                headers["app-version"] = getAppVersion()
//            configuration.HTTPAdditionalHeaders = headers
//            
//            return configuration
//        }()
//        let instance = Manager(configuration: configuration)
//        return instance
//    }
    var sharedManager: Manager {
        struct Singleton {
            static var predicate : dispatch_once_t = 0
            static var instance : Manager? = nil
            
        }
        dispatch_once(&Singleton.predicate, {
            var headers = Manager.sharedInstance.session.configuration.HTTPAdditionalHeaders ?? [:]
            let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
            headers["Appterminal"] = "2"
            headers["Appversion"] = getAppVersion()
            headers["Apptype"] = "1"
            configuration.HTTPAdditionalHeaders = self.httpHeaders
            Singleton.instance = Manager(configuration: configuration)
        })
        return Singleton.instance!
        
    }
    private func startRequest() {
        if hud {
            //            KVNProgress.showWithStatus(hudMsg, onView: delegateVC.view)
            //KVNProgress.showWithStatus(hudMsg)
            if hudMsg.isEmpty {
                SVProgressHUD.show()
            } else {
                SVProgressHUD.showWithStatus(hudMsg)
            }
        }
        zmprint(self.url)
        zmprint(self.params)
    }
    
    private func endRequest(response:Response<AnyObject, NSError>) {
        let ajax = self
        var zjson:Zjson! = nil
        if ajax.hud && ajax.autoHideHud {
            //KVNProgress.dismiss()
            SVProgressHUD.dismiss()
        }
        
        zmprint(response.request)  // original URL request
        zmprint(response.response) // URL response
        //        zmprint(response.data)     // server data
        zmprint(response.result.value)   // result of response serialization
        print(response)
        switch response.result {
        case .Success:
            if let json = response.result.value {
                let json = JSON(json)
                zjson = Zjson(json:json)
                if zjson.success {
                    requestCount = 0
                    if ajax.delegateVC != nil {
                        ajax.success?(json:zjson)
                    }
                }
                if !zjson.success {
                    requestCount++
                    if requestCount < 3 && zjson.code == 401 {
                        appUser = nil
                        Ajax.doLogin(ajax)
                        
                    } else {
                        if ajax.delegateVC != nil {
                            ajax.failure?(json:zjson)
                        }
                        if ajax.failure == nil {
                            if ajax.delegateVC != nil {
                                //                            showError(zjson.detail,"失败")
                                showErrorAlert(zjson.detail,"失败")
                            }
                        }
                    }
                }
            }
            ajax.callback?(json:zjson)
        case .Failure(let error):
            if ajax.delegateVC != nil {
                ajax.error?(error: error)
            }
            zmprint("Error: \(error)")
            zmprint(response.request)
            zmprint(response.response)
            showError("网络好像有些问题，请稍后重试")
        }
    }
    
    func post() {
        self.startRequest()
        self.sharedManager.request(.POST, self.url, parameters:self.params)
            .responseJSON(completionHandler: { (response) -> Void in
                //                self.endRequest(req, res, json, error);
                //                self.endRequest(response.request, response.response, response.data, error);
                self.endRequest(response)
            })
    }
    
    var fArr = [[AnyObject]]()
    var fSuccess : ((fArr:[[AnyObject]])->Void)!
    func fGet(){
        self.startRequest()
        Ajax.fManager.request(.GET, self.url, parameters: self.params).responseJSON { (response) -> Void in
            self.fEndRequest(response)
        }
    }
    class var fManager: Manager {
        struct Singleton {
            static var configuration: NSURLSessionConfiguration = {
                var headers = Manager.sharedInstance.session.configuration.HTTPAdditionalHeaders ?? [:]
                var configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
                headers["app-version"] = getAppVersion()
                configuration.HTTPAdditionalHeaders = headers
                return configuration
            }()
            static let instance = Manager(configuration: configuration)
        }
        return Singleton.instance
    }
    func fEndRequest(response:Response<AnyObject, NSError>){
        let ajax = self
        if ajax.hud && ajax.autoHideHud {
            SVProgressHUD.dismiss()
        }
        var fString = String(data: response.data!, encoding: NSUTF8StringEncoding)
        if fString == ""{
            let fArr = [[AnyObject]]()
            self.fSuccess(fArr: fArr)
            return
        }
        fString = fString?.stringByReplacingOccurrencesOfString("\n", withString: ",")
        let index = fString?.startIndex.advancedBy(fString!.characters.count-1)
        fString = fString?.substringToIndex(index!)
        fString = "[" + fString! + "]"
        let fData = fString!.dataUsingEncoding(NSUTF8StringEncoding)
        let fArr = try? NSJSONSerialization.JSONObjectWithData(fData!, options: NSJSONReadingOptions.MutableContainers) as! [[AnyObject]]
        self.fSuccess(fArr: fArr!)
    }
    
    class func doLogin(oldAjax:Ajax) {
        var useBackgroundInit = false
        
        if let phone = userDefaults.stringForKey(userDefaultsUserName) {
            if let password = userDefaults.stringForKey(userDefaultsUserPassword) {
                useBackgroundInit = true
                let ajax = Ajax(url: "common/authenticate", params: ["customer_phone":phone,"customer_password":password],vc:oldAjax.delegateVC)
                ajax.success = { json in
                    appUser = UserModel(json.addon["customer"])
                    oldAjax.post()
                }
                ajax.failure = {json in
                    if json.code != 4000 {
                        Ajax.popLoginVC(oldAjax)
                    }
                }
                ajax.hud = false
                ajax.post()
            }
        }
        if !useBackgroundInit {
            self.popLoginVC(oldAjax)
        }
    }
    
    class func popLoginVC(ajax:Ajax) {
        if ajax.delegateVC != nil {
            if let tabVC = ajax.delegateVC.tabBarController {
                tabVC.navigationController?.popToRootViewControllerAnimated(true)
            } else {
                ajax.delegateVC.navigationController?.popToRootViewControllerAnimated(true)
            }
        }
    }
    
    func ajaxUpload() {
        self.startRequest()
        
        let urlRequest = self.urlRequestWithComponents(self.url, parameters: params)
        self.sharedManager.upload(urlRequest.0, data: urlRequest.1)
            .responseJSON { (response) in
                //                self.endRequest(req, res, json, error);
                self.endRequest(response)
        }
    }
    
    func addParam(key:String,value:AnyObject) {
        self.params[key] = value
    }
    
    func urlRequestWithComponents(urlString:String, parameters:NSDictionary) -> (URLRequestConvertible, NSData) {
        
        // create url request to send
        let mutableURLRequest = NSMutableURLRequest(URL: NSURL(string: urlString)!)
        mutableURLRequest.HTTPMethod = Method.POST.rawValue
        //let boundaryConstant = "myRandomBoundary12345"
        let boundaryConstant = "NET-POST-boundary-\(arc4random())-\(arc4random())"
        let contentType = "multipart/form-data;boundary="+boundaryConstant
        mutableURLRequest.setValue(contentType, forHTTPHeaderField: "Content-Type")
        mutableURLRequest.setValue("ios " + UIDevice.currentDevice().systemName + " " + UIDevice.currentDevice().systemVersion, forHTTPHeaderField: "app-terminal")
        mutableURLRequest.setValue(getAppVersion(), forHTTPHeaderField: "app-version")
        
        // create upload data to send
        let uploadData = NSMutableData()
        
        // add parameters
        for (key, value) in parameters {
            
            uploadData.appendData("\r\n--\(boundaryConstant)\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
            
            if value is NetData {
                // add image
                let postData = value as! NetData
                
                
                //uploadData.appendData("Content-Disposition: form-data; name=\"\(key)\"; filename=\"\(postData.filename)\"\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
                
                // append content disposition
                let filenameClause = " filename=\"\(postData.filename)\""
                let contentDispositionString = "Content-Disposition: form-data; name=\"\(key)\";\(filenameClause)\r\n"
                let contentDispositionData = contentDispositionString.dataUsingEncoding(NSUTF8StringEncoding)
                uploadData.appendData(contentDispositionData!)
                
                
                // append content type
                //uploadData.appendData("Content-Type: image/png\r\n\r\n".dataUsingEncoding(NSUTF8StringEncoding)!) // mark this.
                let contentTypeString = "Content-Type: \(postData.mimeType.getString())\r\n\r\n"
                let contentTypeData = contentTypeString.dataUsingEncoding(NSUTF8StringEncoding)
                uploadData.appendData(contentTypeData!)
                uploadData.appendData(postData.data)
                
            }else{
                uploadData.appendData("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n\(value)".dataUsingEncoding(NSUTF8StringEncoding)!)
            }
        }
        uploadData.appendData("\r\n--\(boundaryConstant)--\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        
        
        
        // return URLRequestConvertible and NSData
        return (ParameterEncoding.URL.encode(mutableURLRequest, parameters: nil).0, uploadData)
    }
}


enum MimeType: String {
    case ImageJpeg = "image/jpeg"
    case ImagePng = "image/png"
    case ImageGif = "image/gif"
    case Json = "application/json"
    case Unknown = ""
    
    func getString() -> String? {
        switch self {
        case .ImagePng:
            fallthrough
        case .ImageJpeg:
            fallthrough
        case .ImageGif:
            fallthrough
        case .Json:
            return self.rawValue
        case .Unknown:
            fallthrough
        default:
            return nil
        }
    }
}

class NetData
{
    let data: NSData
    let mimeType: MimeType
    let filename: String
    
    init(data: NSData, mimeType: MimeType, filename: String) {
        self.data = data
        self.mimeType = mimeType
        self.filename = filename
    }
    
    init(pngImage: UIImage, filename: String) {
        data = UIImagePNGRepresentation(pngImage)!
        self.mimeType = MimeType.ImagePng
        self.filename = filename
    }
    
    init(jpegImage: UIImage, compressionQuanlity: CGFloat, filename: String) {
        data = UIImageJPEGRepresentation(jpegImage, compressionQuanlity)!
        self.mimeType = MimeType.ImageJpeg
        self.filename = filename
    }
}
