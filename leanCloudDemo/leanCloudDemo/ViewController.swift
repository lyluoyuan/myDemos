//
//  ViewController.swift
//  leanCloudDemo
//
//  Created by zm004 on 16/2/25.
//  Copyright © 2016年 zm004. All rights reserved.
//

import UIKit
import AVFoundation
import MobileCoreServices
import MediaPlayer
class ViewController: UIViewController,AVIMClientDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var client = AVIMClient()
    var conversation : AVIMConversation?
    let audioSession = AVAudioSession.sharedInstance()
    var audioRecorder:AVAudioRecorder!
    var audioPlayer:AVAudioPlayer!
    var recordingName : String!
    var documentDirectory : String!
    var soundString:String!
    var soundURL:NSURL!
    var videoPlayer : MPMoviePlayerController!
    var videoData : NSData!
    
    var avPlayer : AVPlayer!
    var avPlayerLayer : AVPlayerLayer!
    var avplayerItem : AVPlayerItem!
    @IBOutlet weak var videoWrapView: UIView!
    @IBOutlet weak var testLoadLocalImage: UIImageView!
    var recordingMangaer = RecordingManage.shareInstance()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AVIMClient.setUserOptions([AVIMUserOptionUseUnread : true])
        //http://pic.to8to.com/attch/day_160218/20160218_6410eaeeba9bc1b3e944xD5gKKhPEuEv.png
        LYCache.sharedCache().loadLocalImageElseOnline("http://pic.to8to.com/attch/day_160218/20160218_6410eaeeba9bc1b3e944xD5gKKhPEuEv.png", imageView: testLoadLocalImage, placeHolder: "120")
    }
//    func signatureWithClientId(clientId: String!, conversationId: String!, action: String!, actionOnClientIds clientIds: [AnyObject]!) -> AVIMSignature! {
//        let signature = AVIMSignature()
//        print(clientIds)
//        signature.signature = "Jr8FfvOQkk9gcVINXDEvArLR"
//        let timestamp = NSDate(timeIntervalSinceNow: 0)
//        
//        signature.timestamp = Int64(timestamp.timeIntervalSince1970)
//        signature.nonce = String(random())
//        return signature
//    }
    func tomSendMessageToJerry(){

        self.client = AVIMClient(clientId: "Tom")
        if self.conversation == nil{
            
            self.client.openWithCallback { (succeeded, error) -> Void in
                self.client.createConversationWithName("TomAndJerry", clientIds: ["Jerry"], callback: { (conversation, error) -> Void in
                    self.conversation = conversation
                    conversation.sendMessage(AVIMTextMessage(text: "Jerry,get up", attributes: nil), callback: { (succeeded, error) -> Void in
                        if succeeded{
                            print("发送成功")
                        }
                    })
                })
            }
        }else{
            self.conversation?.sendMessage(AVIMTextMessage(text: "Jerry,get up", attributes: nil), callback: { (succeeded, error) -> Void in
                if succeeded{
                    print("发送成功")
                }
            })
        }

        
//        let vc = UIImagePickerController()
//        vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
//        vc.delegate = self
//        self.presentViewController(vc, animated: true, completion: { () -> Void in
//            
//        })
        
//        self.client.openWithCallback { (succeeded, error) -> Void in
//            let query = self.client.conversationQuery()
//            query.limit = 5
//            
//            query.findConversationsWithCallback({ (objects, error) -> Void infoin
//                print(objects)
//                print(objects.count)
//            })
//        }
    }
    
//    func conversation(conversation: AVIMConversation!, didReceiveUnread unread: Int) {
//        print(UInt(unread))
//        if unread <= 0 {
//            return
//        }
//        
////        conversation.queryMessagesFromServerWithLimit(UInt(unread)) { (messages, error) -> Void in
////            print(messages.count)
////        }
//
//        print("aaa")
//    }
    

    
//    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
//        
//    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
//        let mediaType = info[UIImagePickerControllerMediaType]
        if picker.cameraCaptureMode == UIImagePickerControllerCameraCaptureMode.Video{
            picker.dismissViewControllerAnimated(true, completion: { () -> Void in
                self.client.openWithCallback({ (succeeded, error) -> Void in
                    self.client.createConversationWithName("TomAndJerry", clientIds: ["Jerry"], callback: { (conversation, error) -> Void in
                        let url = info[UIImagePickerControllerMediaURL] as! NSURL
                        let videoMessage = AVIMVideoMessage(text: "看", file: AVFile(name: "vvv.mp4", contentsAtPath: url.path), attributes: nil)
                        conversation.sendMessage(videoMessage, callback: { (succeeded, error) -> Void in
                            print("发视成功")
                        })
                    })
                })
                AVPlayer
                return
            })
        }
        picker.dismissViewControllerAnimated(true) { () -> Void in
            self.client.openWithCallback { (succeeded, error) -> Void in
                self.client.createConversationWithName("TomAndJerry", clientIds: ["Jerry"], callback: { (conversation, error) -> Void in
                    var image = UIImage()
                    if picker.allowsEditing{
                        image = info[UIImagePickerControllerEditedImage] as! UIImage
                    }else{
                        image = info[UIImagePickerControllerOriginalImage] as! UIImage
                    }
                    let imageMessage = AVIMImageMessage(text: "aaa", file: AVFile(data: UIImageJPEGRepresentation(image,1)), attributes: nil)
                    
                    conversation.sendMessage(imageMessage, callback: { (succeeded, error) -> Void in
                        if succeeded{
                            print("发送成功")
                        }
                    })
                })
            }
        }
    }
    func jerryReceiveMessageFromTom(){
        self.client = AVIMClient(clientId: "Jerry")
        self.client.delegate = self
        self.client.openWithCallback { (succeeded, error) -> Void in
            
        }
    }
    @IBOutlet weak var receivedImageView: UIImageView!
    func conversation(conversation: AVIMConversation!, didReceiveTypedMessage message: AVIMTypedMessage!) {
        print(message.text)
//        if message.mediaType == kAVIMMessageMediaTypeImage{
//            print("是图")
//            let imageMessage = message as! AVIMImageMessage
//            print(imageMessage.file.url)
//            self.receivedImageView.sd_setImageWithURL(NSURL(string: imageMessage.file.url), placeholderImage: UIImage(named: "120"))
//        }

        if message.mediaType == kAVIMMessageMediaTypeAudio{
            let audioMessage = message as! AVIMAudioMessage
            print(audioMessage.file.url)
            
            let audioData = NSData(contentsOfURL: NSURL(string: audioMessage.file.url)!)
            let filePath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first! + "/\(audioMessage.file.objectId).mp3"
            print(filePath)
            audioData?.writeToFile(filePath, atomically: true)
            
            let fileURL = NSURL(fileURLWithPath: filePath)
            do {
                try audioPlayer = AVAudioPlayer(data: NSData(contentsOfFile: filePath)!)
                audioPlayer.prepareToPlay()
                audioPlayer.play()
            }catch{
                print(error)
            }
            return
        }
        
        if message.mediaType == kAVIMMessageMediaTypeVideo{
            
            let videoMessage = message as! AVIMVideoMessage
            videoData = NSData(contentsOfURL: NSURL(string: videoMessage.file.url)!)
            let filePath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first! + "/\(videoMessage.file.objectId).mp4"
            videoData?.writeToFile(filePath, atomically: true)
            let fileURL = NSURL(fileURLWithPath: filePath)
            print(videoMessage.file.url)
            print(fileURL)
//            videoPlayer = MPMoviePlayerController(contentURL: NSURL(string: videoMessage.file.url)!)
            videoPlayer = MPMoviePlayerController(contentURL: fileURL)
            videoPlayer.view.frame = view.frame
            videoPlayer.view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth , UIViewAutoresizing.FlexibleHeight]
            view.addSubview(videoPlayer.view)
            videoPlayer.play()
        }
    }
    @IBAction func recordVedioAction(sender: UIButton) {
        let vc = UIImagePickerController()
        vc.sourceType = UIImagePickerControllerSourceType.Camera
        vc.cameraDevice = UIImagePickerControllerCameraDevice.Rear
        vc.videoMaximumDuration = 15
        vc.mediaTypes = [kUTTypeMovie as String]
        vc.videoQuality = UIImagePickerControllerQualityType.TypeHigh
        vc.cameraCaptureMode = UIImagePickerControllerCameraCaptureMode.Video
        vc.allowsEditing = true
        vc.delegate = self
        self.presentViewController(vc, animated: true, completion: { () -> Void in
            
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func sendAction(sender: UIButton) {

        tomSendMessageToJerry()
    }

    @IBAction func receivedAction(sender: UIButton) {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
        jerryReceiveMessageFromTom()
    }
    @IBAction func touchDownForBegin(sender: UIButton) {
//        let recordSettings = [AVSampleRateKey : NSNumber(float: Float(44100.0)),//声音采样率
//            AVFormatIDKey : NSNumber(int: Int32(kAudioFormatMPEG4AAC)),//编码格式
//            AVNumberOfChannelsKey : NSNumber(int: 1),//采集音轨
//            AVEncoderAudioQualityKey : NSNumber(int: Int32(AVAudioQuality.Medium.rawValue))]//音频质量
//        do {
//            try audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
//            try audioRecorder = AVAudioRecorder(URL: self.directoryURL()!,
//                settings: recordSettings)//初始化实例
//
//            audioRecorder.prepareToRecord()//准备录音
//        } catch {
//        }
//        if !audioRecorder.recording {//判断是否正在录音状态
//            let audioSession = AVAudioSession.sharedInstance()
//            do {
//                try audioSession.setActive(true)
//                audioRecorder.record()
//                print("record!")
//            } catch {
//            }
//        }
        audioRecorder = recordingMangaer.audioSetting(self)
        recordingMangaer.startRecord(audioRecorder)
    }

    @IBAction func touchUpInsideForStop(sender: AnyObject) {
        recordingMangaer.stopRecord(audioRecorder)
        recordingMangaer.audio_PCMtoMP3(recordingMangaer.getRecordingURL(), andMP3FilePath: recordingMangaer.getRecordingMP3URL())

        let audioMessage = AVIMAudioMessage(text: "听", file: AVFile(name: "lll.mp3", contentsAtPath: recordingMangaer.getRecordingMP3URL()), attributes: nil)
//        let audioMessage = AVIMAudioMessage(text: "听", file: AVFile(URL: recordingMangaer.getRecordingMP3URL()), attributes: nil)
        print("recordingMangaer.getRecordingMP3URL(): \(recordingMangaer.getRecordingMP3URL())")
//        let audioMessage = AVIMAudioMessage(text: "听", file: AVFile(data: NSData()), attributes: nil)
        
        if self.conversation != nil{
        self.conversation?.sendMessage(audioMessage, callback: { (succeeded, error) -> Void in
            if succeeded{
                print("发送语音成功")
            }else{
                print("发送语音失败")
                print(error)
            }
        })
        }else{
            print("conversation不存在")
        }
        
//        if (!audioRecorder.recording){
//            do {
//                NSURL(string: recordingMangaer.getRecordingMP3URL())!
//                print(NSURL(string: recordingMangaer.getRecordingURL()))
//                try audioPlayer = AVAudioPlayer(contentsOfURL:  NSURL(string: recordingMangaer.getRecordingURL())!)
//                audioPlayer.play()
//                print("play!!")
//            } catch {
//                print(error)
//            }
//        }
    }
    @IBAction func localImagesSize(sender: UIButton) {
        print(LYCache.sharedCache().getLocalImagesSize())
        
    }
    @IBAction func clearLocalImages(sender: UIButton) {
        LYCache.sharedCache().clearLocalImages()
    }
 
}

