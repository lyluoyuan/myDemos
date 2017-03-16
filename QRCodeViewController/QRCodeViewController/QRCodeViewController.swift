//
//  QRCodeViewController.swift
//  QRCodeViewController
//
//  Created by zm004 on 16/6/2.
//  Copyright © 2016年 zm004. All rights reserved.
//

import UIKit
import AVFoundation
class QRCodeViewController: UIViewController,AVCaptureMetadataOutputObjectsDelegate {
    @IBOutlet weak var scanView: UIView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!

    var device : AVCaptureDevice!
    var input : AVCaptureDeviceInput!
    var output : AVCaptureMetadataOutput!
    var session : AVCaptureSession!
    var preview : AVCaptureVideoPreviewLayer!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "二维码"
        
        view.layoutSubviews()
        view.setNeedsLayout()
        view.layoutIfNeeded()
        
//        contentLabel.removeFromSuperview()
//        cancelButton.removeFromSuperview()
        scanView.hidden = true
        contentLabel.textColor = UIColor.whiteColor()
        
        device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        input = try! AVCaptureDeviceInput(device: device)
        output = AVCaptureMetadataOutput()
        output.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
        session = AVCaptureSession()
        session.sessionPreset = AVCaptureSessionPresetHigh
        if session.canAddInput(input){
            session.addInput(input)
        }
        if session.canAddOutput(output){
            session.addOutput(output)
        }
        var qrcodeItems = [AVMetadataObjectTypeQRCode,AVMetadataObjectTypeCode39Code,AVMetadataObjectTypeCode128Code,AVMetadataObjectTypeCode39Mod43Code,AVMetadataObjectTypeEAN13Code,AVMetadataObjectTypeEAN8Code,AVMetadataObjectTypeCode93Code]
        if #available(iOS 8.0, *) {
            qrcodeItems.append(AVMetadataObjectTypeDataMatrixCode)
        }
        output.metadataObjectTypes = qrcodeItems
        preview = AVCaptureVideoPreviewLayer(session: session)
        preview.videoGravity = AVLayerVideoGravityResizeAspectFill
        preview.frame = self.view.layer.bounds
        preview.frame.origin.y = 60
        view.layer.addSublayer(preview)
        let rawScanRect = scanView.frame

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "avCaptureInputPortFormatDescriptionDidChangeNotification", name: AVCaptureInputPortFormatDescriptionDidChangeNotification, object: nil)//

        
        let path = UIBezierPath(roundedRect: rawScanRect, cornerRadius: 5)
        let shape = CAShapeLayer()
        shape.path = path.CGPath
        shape.strokeColor = UIColor.greenColor().CGColor
        shape.fillColor = UIColor.clearColor().CGColor
        shape.lineWidth = 3
        shape.lineDashPattern = [7.0,7.0]
        shape.lineDashPhase = 0
        preview.addSublayer(shape)
        
        session.startRunning()
        
        view.addSubview(contentLabel)
        view.addSubview(cancelButton)
    }
    func avCaptureInputPortFormatDescriptionDidChangeNotification(){
        let convertRect = preview.metadataOutputRectOfInterestForRect(CGRectMake(0, 60, 300, 300))
        print(convertRect)
        output.rectOfInterest = convertRect
    }
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        var stringValue : String!
        if metadataObjects.count > 0{
            session.stopRunning()
            let metadataObject = metadataObjects.first!
            stringValue = metadataObject.stringValue
            print(stringValue)
        }
    }
    
}
