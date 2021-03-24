//
//  MusicBankPlayerViewController.swift
//  MusicBank
//
//  Created by flqy on 2021/3/13.
//  Copyright © 2021 onelact. All rights reserved.
//

import UIKit
import Kingfisher
import MediaPlayer

class MusicBankPlayerViewController: MusicBankViewController {

    /*---------------------- background ------------------------*/
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    
    /*----------------------- Navi -----------------------*/
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var artistLabel: UILabel!
    
    @IBOutlet weak var shareButton: UIButton!
    
    @IBOutlet weak var backButton: UIButton!
    
    
    /*----------------------------------------------*/
    
    @IBOutlet weak var artistBackgroundView: UIView!
    
    @IBOutlet weak var artistBackgroundImageView: UIImageView!
    
    @IBOutlet weak var artistImageView: UIImageView!
    
    
    /*----------------------------------------------*/

    @IBOutlet weak var positionLabel: UILabel!
    
    @IBOutlet weak var durationLabel: UILabel!
    
    @IBOutlet weak var positionView: UIView!
    
    @IBOutlet weak var positionLayoutConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var durationView: UIView!
    
    @IBOutlet weak var positionButton: UIView!
    
    
    /*----------------------------------------------*/
    
    @IBOutlet weak var previousButton: UIButton!
    
    @IBOutlet weak var playButton: UIButton!
    
    @IBOutlet weak var nextButton: UIButton!
    
    private var player: MusicBankPlayer?
    
    var assets: [AssetItemModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            // 直接开始播放
            player = try MusicBankPlayer(assets: [])
            player?.delegate = self
        } catch let error {
            assert(false,error.localizedDescription)
        }
        // Do any additional setup after loading the view.
    }
    
    
    // MARK: 设置播放进度
    func setSeek(to position: TimeInterval) {
        self.player?.seek(to: position)
    }
    
    // MARK: 手势响应
    /*----------------------------------------------*/
    
    @IBAction func tapArtistBackgroundViewAction(_ sender: Any) {
        // TODO: 歌词和封面切换
    }
    
    //代理--手势识别器是否能够开始识别手势.
//    当手势识别器识别到手势,准备从UIGestureRecognizerStatePossible状态开始转换时.调用此代理,如果返回YES,那么就继续识别,如果返回NO,那么手势识别器将会将状态置为UIGestureRecognizerStateFailed.

    
    @IBAction func panPositionButtonView(_ sender: UIPanGestureRecognizer) {
        
        
        let point = sender.location(in: self.durationView)
        debugPrint("活动的位置点",sender.state.rawValue, point,self.durationView.frame.width)
        switch sender.state {
        
        case .possible:
            break
        case .began:
            // 放大
//            self.durationView.transform = CGAffineTransform.identity.scaledBy(x: 1, y: 2)
            break
        case .changed:
            break
        case .ended:
            self.durationView.transform = CGAffineTransform.identity
            break
        case .cancelled:
            self.durationView.transform = CGAffineTransform.identity
            break
        case .failed:
            self.durationView.transform = CGAffineTransform.identity
            break
        @unknown default:
            self.durationView.transform = CGAffineTransform.identity
            break
        }
        
//        CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view];
//        //相对有手势父视图的坐标点(注意如果父视图是scrollView,locationPoint.x可能会大于视图的width)
//        CGPoint locationPoint = [gestureRecognizer locationInView:gestureRecognizer.view];
//
    }
    
    @IBAction func tapPositionButtonAction(_ sender: Any) {
        // TODO: 拖动进度条
        // 开始选中的时候 进度条应该有一个放大效果
        // 并且变亮
        debugPrint("点击这个手势")
        self.durationView.transform = CGAffineTransform.identity.scaledBy(x: 1, y: 2)
    }
    
    
    // MARK: 按钮响应
    /*----------------------------------------------*/
    @IBAction func backButtonAction(_ sender: Any) {
        // TODO: 设置转场效果
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func shareButtonAction(_ sender: Any) {
        
    }
    
    @IBAction func previousButtonAction(_ sender: Any) {
        self.player?.previousTrack()
    }
    
    @IBAction func playButtonAction(_ sender: Any) {
        self.player?.togglePlayPause()
    }
    
    @IBAction func nextButtonAction(_ sender: Any) {
        self.player?.nextTrack()
    }
    
    
}

extension MusicBankPlayerViewController: MusicBankPlayerDelegate {
    
    func readyToPlay(player: AVPlayer, asset: AVPlayerItem) {
        debugPrint("准备好开始播放")
    }
    
    func playerFailed(player: AVPlayer, asset: AVPlayerItem?, error: Error?) {
        debugPrint("播放失败",error)
    }
    
    func player(player: AVPlayer, asset: AVPlayerItem, position: Float, duration: Float) {
        debugPrint("播放进度")
    }
    
    func player(playing: Bool) {
        
    }
    
}
