//
//  AppUtils.swift
//  eshangk-ios
//
//  Created by zm002 on 15/1/7.
//  Copyright (c) 2015年 zm002. All rights reserved.
//

import UIKit


@objc protocol vcProtocol {
   optional func afterLogin() -> Void
    
    optional func doRefresh(data:AnyObject?) -> Void
    
    optional func doDismiss() -> Void
    
    optional func doAlipayResult(status:Int) -> Void
}

func zmprint(text:AnyObject?) {
    #if DEBUG
        print(text)
        #else
    #endif
}

func showError(desc:String,_ title:String = "失败") {
    //    TWMessageBarManager.sharedInstance().showMessageWithTitle(title, description: desc, type: TWMessageBarMessageType.Error)
    ZMMessageView.show(desc)
}

func showSuccess(desc:String,_ title:String = "成功!") {
    //   TWMessageBarManager.sharedInstance().showMessageWithTitle(title, description: desc, type: TWMessageBarMessageType.Success)
    ZMMessageView.show(desc)
}

func showMessage(desc:String,_ title:String = "提示!") {
    //    TWMessageBarManager.sharedInstance().showMessageWithTitle(title, description: desc, type: TWMessageBarMessageType.Info)
    ZMMessageView.show(desc)
}

func showSuccessAlert(msg:String,_ title:String = "成功!") {
    SweetAlert(true).buildAlert(title, subTitle: msg, style: AlertStyle.Success).show()
}

func showErrorAlert(msg:String,_ title:String = "失败") {
    SweetAlert(true).buildAlert(title, subTitle: msg, style: AlertStyle.Error).show()
}

func showInfoAlert(msg:String,_ title:String = "提示!") {
    SweetAlert(true).buildAlert(title, subTitle: msg, style: AlertStyle.None).show()
}

func isCameraAvailable() -> Bool {
    return UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
}

func isRearCameraAvailable() -> Bool {
    return UIImagePickerController.isCameraDeviceAvailable(UIImagePickerControllerCameraDevice.Rear)
}

func isFrontCameraAvailable() -> Bool {
    return UIImagePickerController.isCameraDeviceAvailable(UIImagePickerControllerCameraDevice.Front)
}

func isPhotoLibraryAvailable() -> Bool {
    return UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary)
}

func checkTableViewIsEmpty(tableView:UITableView) -> Bool {
    var isEmpty = true
    for i in  0..<tableView.numberOfSections {
        if tableView.numberOfRowsInSection(i) > 0 || tableView.headerViewForSection(i) != nil {
            isEmpty = false
            break
        }
    }
    return isEmpty
}

func checkCollectionViewIsEmpty(collectionView:UICollectionView) -> Bool {
    var isEmpty = true
    for i in  0..<collectionView.numberOfSections() {
        if collectionView.numberOfItemsInSection(i) > 0  {
            isEmpty = false
            break
        }
    }
    return isEmpty
}

func JSONStringify(value: AnyObject, prettyPrinted: Bool = false) -> String {
    let options = prettyPrinted ? NSJSONWritingOptions.PrettyPrinted : NSJSONWritingOptions(rawValue:0)
    if NSJSONSerialization.isValidJSONObject(value) {
        if let data = try? NSJSONSerialization.dataWithJSONObject(value, options: options) {
            if let string = NSString(data: data, encoding: NSUTF8StringEncoding) {
                return string as String
            }
        }
    }
    return ""
}

func getTimeButSecond(time: String) -> String {
    if time.length > 5 {
        return (time as NSString).substringWithRange(NSMakeRange(0, 5))
    }
    return time
}

func configueCellStyle(cell:UITableViewCell) {
//    cell.selectionStyle = .None
    cell.backgroundColor = UIColor.hex( "#f0f0f0")
//    let v = UIView()
//    v.backgroundColor = UIColor.hex( "#f9a492")
//    cell.selectedBackgroundView = v
    if cell.respondsToSelector("setSeparatorInset:") {
        cell.separatorInset = UIEdgeInsetsZero
    }
    if #available(iOS 8.0, *) {
        cell.layoutMargins = UIEdgeInsetsZero
        cell.preservesSuperviewLayoutMargins = false
    }
}

func renderCellNoneSelectedStyle(cell:UITableViewCell) {
    let v = UIView()
//    if selected {
//        v.backgroundColor = UIColor.hex( "#dfdfdf")
//    } else {
        v.backgroundColor = UIColor.clearColor()
//    }
    
    cell.selectedBackgroundView = v
}

func configueTableVieStyle(tableView:UITableView) {
    tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
//    tableView.separatorInset = UIEdgeInsetsZero
//    if tableView.respondsToSelector("setLayoutMargins:") {
//        tableView.layoutMargins = UIEdgeInsetsZero
//    }
    
    tableView.backgroundColor = mainBgColor
    
    tableView.tableFooterView = UIView(frame: CGRectZero)
    tableView.layoutIfNeeded()
}

func fixTableCellSelectedStyle(tableView:UITableView,indexPath:NSIndexPath) {
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
}

func getAppVersion() -> String {
    return NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleShortVersionString") as! String
}

//func clearWeixinUrl(data:String) -> String {
//    return data.stringByReplacingOccurrencesOfString(weixinWebUrl, withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
//}
//
//func clearOrderUrl(data:String) -> String {
//    return data.stringByReplacingOccurrencesOfString(orderWebUrl, withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
//}

func delay(delay:Double, closure:()->()) {
    dispatch_after(
        dispatch_time(
            DISPATCH_TIME_NOW,
            Int64(delay * Double(NSEC_PER_SEC))
        ),
        dispatch_get_main_queue(), closure)
}

func renderBandCardNumber(var text:String) -> String {
    let characterSet = NSCharacterSet(charactersInString: "0123456789\\b")
    
    text = text.stringByReplacingOccurrencesOfString(" ", withString: "")
    
    var newString = ""
    
    while text.length > 0 {
        
        let subString = (text as NSString).substringToIndex(min(text.length, 4))
        
        newString += subString
        
        if subString.length == 4 {
            newString += " "
        }
        
        text = (text as NSString).substringFromIndex(min(text.length, 4))
    }
    
    newString = newString.stringByTrimmingCharactersInSet(characterSet.invertedSet)
    
    
    return newString
}

func SYSTEM_VERSION_EQUAL_TO(version: String) -> Bool {
    return UIDevice.currentDevice().systemVersion.compare(version,
        options: NSStringCompareOptions.NumericSearch) == NSComparisonResult.OrderedSame
}

func SYSTEM_VERSION_GREATER_THAN(version: String) -> Bool {
    return UIDevice.currentDevice().systemVersion.compare(version,
        options: NSStringCompareOptions.NumericSearch) == NSComparisonResult.OrderedDescending
}

func SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(version: String) -> Bool {
    return UIDevice.currentDevice().systemVersion.compare(version,
        options: NSStringCompareOptions.NumericSearch) != NSComparisonResult.OrderedAscending
}

func SYSTEM_VERSION_LESS_THAN(version: String) -> Bool {
    return UIDevice.currentDevice().systemVersion.compare(version,
        options: NSStringCompareOptions.NumericSearch) == NSComparisonResult.OrderedAscending
}

func SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(version: String) -> Bool {
    return UIDevice.currentDevice().systemVersion.compare(version,
        options: NSStringCompareOptions.NumericSearch) != NSComparisonResult.OrderedDescending
}

class AppUtils: NSObject,UIAlertViewDelegate {
    
    var updateUrl:String = ""
    var flgNeedUpdate:Bool = false
    
    func updateAppIfNeeded(vc:UIViewController,showHud:Bool = false) {
        let ajax = Ajax(url: "common/getUpdateInfo", params: nil,vc:vc)
        ajax.success = { json in
            let version = json.addon["app_version"].stringValue
            let appVersion = getAppVersion()
            
            if version > appVersion {
                self.flgNeedUpdate = true
                let content = json.addon["app_update_detail"].stringValue
                self.updateUrl = json.addon["update_url"].stringValue
//                let alertView = UIAlertView(title: "检测到新版本\(version)", message:  "更新内容:\(content)", delegate: self, cancelButtonTitle: "取消", otherButtonTitles: "更新")
//                alertView.show()
                SweetAlert(true).buildAlert("检测到新版本\(version)", subTitle: "更新内容:\(content)", style: .None, buttonTitle: "取消", otherButtonTitle: "升级", action: { (isOtherButton, alert) -> Void in
                    alert.hide()
                    if isOtherButton {
                        UIApplication.sharedApplication().openURL(NSURL(string: json.addon["update_url"].stringValue)!)
                    }
                }).show()
            } else if showHud {
                showSuccessAlert("已更新最新版本")
            }
        }
        ajax.hud = showHud
        ajax.post()
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if buttonIndex == 1 {
            UIApplication.sharedApplication().openURL(NSURL(string: updateUrl)!)
        }
    }
}
