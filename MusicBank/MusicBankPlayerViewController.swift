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

// 音乐播放需要用单里

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
    
    @IBOutlet weak var positionButton: UIButton!
    
    
    /*----------------------------------------------*/
    
    @IBOutlet weak var previousButton: UIButton!
    
    @IBOutlet weak var playButton: UIButton!
    
    @IBOutlet weak var nextButton: UIButton!
    
    private var player: MusicBankPlayer?
    
    var assets: [AssetItemModel] = []
    
    /// 当前播放歌曲时长
    var currentDuration: Float = 0
    
    private var isTouchPositionButton = false {
        didSet {
            if isTouchPositionButton {
                self.durationView.transform = CGAffineTransform.identity.scaledBy(x: 1, y: 2)
                self.positionButton.transform = CGAffineTransform.identity.scaledBy(x: 1.2, y: 1.2)
            } else {
                self.durationView.transform = CGAffineTransform.identity
                self.positionButton.transform = CGAffineTransform.identity
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var song = AssetItemModel()
        
        song.title = "富士山下"
        song.artist = "陈奕迅"
        song.assetURL = URL(string: "http://music.163.com/song/media/outer/url?id=65766")
        song.artworkURL = URL(string: "https://bkimg.cdn.bcebos.com/pic/79f0f736afc37931e4c8b22be1c4b74543a9110b?x-bce-process=image/watermark,image_d2F0ZXIvYmFpa2UxMTY=,g_7,xp_5,yp_5/format,f_auto")
        do {
            // 直接开始播放
            player = try MusicBankPlayer(assets: [song],delegate: self)
        } catch let error {
            assert(false,error.localizedDescription)
        }
        startPlayAnimation()
        // Do any additional setup after loading the view.
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        if self.artistBackgroundImageView.tag == 0 {
//
//        }
//    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.artistBackgroundImageView.tag = 100
        self.artistBackgroundImageView.layer.cornerRadius = self.artistBackgroundImageView.frame.width / 2.0
        self.artistBackgroundView.layer.cornerRadius = self.artistBackgroundView.frame.width / 2.0
        self.artistImageView.layer.cornerRadius = self.artistImageView.frame.width / 2.0
        self.positionButton.layer.cornerRadius = self.positionButton.frame.width / 2.0
    }
        
    private
    func startPlayAnimation() {
        artistImageView.isUserInteractionEnabled = true
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.fromValue = 0.0
        rotationAnimation.toValue = Double.pi * 2.0
        rotationAnimation.duration = 1.25
        rotationAnimation.isCumulative = true
        rotationAnimation.repeatCount = 10
        rotationAnimation.fillMode = .forwards
        artistImageView.layer.add(rotationAnimation, forKey: "rotationAnimation")
        
    }
    
    private
    func stopPlayAnimation() {
        
    }
    
    // MARK: 设置播放进度
    private
    func setSeek(to position: TimeInterval) {
        self.player?.seek(to: position)
    }
    
    // MARK: 手势响应
    /*----------------------------------------------*/
    
    @IBAction func tapArtistBackgroundViewAction(_ sender: Any) {
        // TODO: 歌词和封面切换
    }
    
    @IBAction func panPositionButtonView(_ sender: UIPanGestureRecognizer) {
        
        
        let point = sender.location(in: self.durationView)
        debugPrint("活动的位置点",sender.state.rawValue, point,self.durationView.frame.width)
        switch sender.state {
        
        case .possible:
            break
        case .began:

            break
        case .changed:
            let multiplier = point.x / self.durationView.frame.width
            if multiplier >= 0.0,  multiplier <= 1.0 {
                self.positionLayoutConstraint.constant = point.x
            }
            
            
            break
        case .ended:
            let multiplier = point.x / self.durationView.frame.width
            if multiplier >= 0.0,  multiplier <= 1.0 {
                
                let position = currentDuration * Float(multiplier)
                debugPrint("计算播放进度",position,currentDuration,multiplier)
                setSeek(to: TimeInterval(position))
            }
            isTouchPositionButton = false

            break
        case .cancelled:
            isTouchPositionButton = false
            break
        case .failed:
            isTouchPositionButton = false
            break
        @unknown default:
            isTouchPositionButton = false
            break
        }
        
    }
    
    @IBAction func positionButtonDownAction(_ sender: Any) {
        isTouchPositionButton = true
    }
    
    @IBAction func positionButtonUpAction(_ sender: Any) {
        isTouchPositionButton = false
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
    
    func readyToPlay(player: AVPlayer, asset: AVPlayerItem, duration: Float, metadata: MusicBankPlayableStaticMetadata) {
        
        self.titleLabel.text = metadata.title
        self.artistLabel.text = metadata.artist
        artistImageView.kf.setImage(with: metadata.artworkURL, placeholder: nil, options: nil, completionHandler: nil)
        
        self.positionLayoutConstraint.constant = 0
        self.positionLabel.text = "00:00"
        self.durationLabel.text = duration.durationTime
    }
    
    func playerFailed(player: AVPlayer, asset: AVPlayerItem?, error: Error?) {
        
        debugPrint("播放失败",error)
    }
    
    func player(player: AVPlayer, asset: AVPlayerItem, position: Float, duration: Float) {
        
        let multiplier = position / duration
        
        let width = multiplier * Float(self.durationView.frame.width)
        
        if multiplier >= 0.0,  multiplier <= 1.0 {
            if isTouchPositionButton == false {
                UIView.animate(withDuration: 0.02) {
                    self.positionLayoutConstraint.constant = CGFloat(width)
                }
            }
        }
        
        self.positionLabel.text = position.durationTime
        
        if self.currentDuration != duration {
            self.durationLabel.text = duration.durationTime
            self.currentDuration = duration
        }
        
    }
    
    func player(playing: Bool) {
        
    }
    
}

extension Float {
    var durationTime: String {
        
        if self.isNaN {
            return "00:00"
        }
        if self.isZero {
            return "00:00"
        }
        
        let min = Int(self) / 60
        let sec = Int(self) % 60
        let minStr = String.init(format: "%02d", min)
        let secStr = String.init(format: "%02d", sec)
        return "\(minStr):\(secStr)"
    }
}
