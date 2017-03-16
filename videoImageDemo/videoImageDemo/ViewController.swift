//
//  ViewController.swift
//  videoImageDemo
//
//  Created by zm004 on 16/7/20.
//  Copyright © 2016年 zm004. All rights reserved.
//

import UIKit
import MediaPlayer
class ViewController: UIViewController {
    var videoImageView:UIImageView!
    var moviePlayer:MPMoviePlayerController!
    override func viewDidLoad() {
        super.viewDidLoad()
        videoImageView = UIImageView(frame: CGRectMake(50,50,200,200))
        view.addSubview(videoImageView)
        moviePlayer = MPMoviePlayerController(contentURL: NSURL(string: "http://lsdq.me/jz.mp4"))
        moviePlayer.requestThumbnailImagesAtTimes([5.0], timeOption: MPMovieTimeOption.NearestKeyFrame)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.mediaPlayerThumbnailRequestFinished(_:)), name: MPMoviePlayerThumbnailImageRequestDidFinishNotification, object: nil)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func mediaPlayerThumbnailRequestFinished(notification:NSNotification){
        print(notification.userInfo)
        if let image = notification.userInfo![MPMoviePlayerThumbnailImageKey] as? UIImage{
            
            videoImageView.image = image
        }
    }

}

