//
//  CustomPlayerViewController.swift
//  PIPPLayer
//
//  Created by Dhanunjay Kumar on 06/01/24.
//

import UIKit
import AVKit
import AVFoundation

class CustomPlayerViewController: UIViewController {
    
    var avpController = AVPlayerViewController()
    var player : AVPlayer!
    
    @IBOutlet weak var buttonsViewTop: NSLayoutConstraint!
    
    @IBOutlet weak var heightOfSubView: NSLayoutConstraint!
    @IBOutlet weak var widthOfsubView: NSLayoutConstraint!
    
    lazy var blurredView: UIView = {
        
        let containerView = UIView()
        let dimmedView = UIView()
        dimmedView.backgroundColor = UIColor.black.withAlphaComponent(0.6) // .black.withAlphaComponent(0.6)
        dimmedView.frame = self.view.bounds
        containerView.addSubview(dimmedView)
        return containerView
    }()
    
    
    @IBOutlet weak var bottomOfCTAButton: NSLayoutConstraint!
    @IBOutlet weak var heightOfCTAButton: NSLayoutConstraint!
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var expandButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var volumeButton: UIButton!
    
    @IBOutlet weak var buttonsView: UIView!
    
    @IBOutlet weak var ctaButton: UIButton!
    @IBOutlet weak var playerView: UIView!
    
    private var playerLayer: AVPlayerLayer?
    private var pictureInPictureController: AVPictureInPictureController?
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        startVideo()
        expandButton.tag = 1
        self.pipStart(expandButton)

        
    }
    func startVideo() {
        
        let url = URL(string: "https://firebasestorage.googleapis.com/v0/b/gameofchats-762ca.appspot.com/o/message_movies%2F12323439-9729-4941-BA07-2BAE970967C7.mov?alt=media&token=3e37a093-3bc8-410f-84d3-38332af9c726")!
        player = AVPlayer(url: url)
        
        avpController.player = self.player
        
        avpController.view.frame.size.height = self.playerView.frame.size.height
        avpController.view.frame.size.width = self.playerView.frame.size.width
        
        self.playerView.addSubview(avpController.view)
        player.externalPlaybackVideoGravity = .resizeAspectFill
        avpController.videoGravity = .resizeAspectFill
        avpController.view.layer.cornerRadius = 12
        playerView.layer.cornerRadius = 12
        
        avpController.showsPlaybackControls = false
                
        player.play()
                    
    }

    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
            
        self.playerView.bringSubviewToFront(buttonsView)
    }
    
    override public func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        playerLayer?.frame = playerView.bounds
    }
        
    
    func setupView() {
        view.addSubview(blurredView)
        view.sendSubviewToBack(blurredView)
    }
    @objc func playerDidFinishPlaying() {
        self.close(UIButton())
    }
    @IBAction func close(_ sender: Any) {
        player?.rate = 0
        dismiss(animated: true)
    }
    
    @IBAction func volumeBtnClicked(_ sender: UIButton) {
        
        self.player?.isMuted = (!(self.player?.isMuted ?? false))
        
        if self.player?.isMuted ?? false {
            volumeButton.setImage(UIImage.init(named: "pipVol"), for: .normal)
        } else {
            volumeButton.setImage(UIImage.init(named: "pip_unmute"), for: .normal)
        }
    }
    
    @IBAction func pipStart(_ sender: UIButton) {
        avpController.view.layer.cornerRadius = 12
        self.playerView.layer.cornerRadius = 12
        
        self.ctaButton.isHidden = true
        if (sender.tag == 0) {
            
            sender.tag = 1 // Expand
            
            buttonsViewTop.constant = 70
            self.leadingConstraint.constant = 0
            self.bottomConstraint.constant = 0
            
            self.playerView.layer.cornerRadius = 10
            self.playerLayer?.cornerRadius = 0
            
            self.heightOfSubView.constant = self.view.frame.height
            self.widthOfsubView.constant = self.view.frame.width
            
            self.leadingConstraint.constant = 0
            self.bottomConstraint.constant = -31
            
            
        } else {
            sender.tag = 0 // shrink
            
            print("pipStart COLLLPASEEEEEEE")
            
            buttonsViewTop.constant = 5
            self.ctaButton.isHidden = true
            
            self.heightOfSubView.constant = 254
            self.widthOfsubView.constant = 186
            
            self.playerLayer?.masksToBounds = true
            self.playerView.layer.cornerRadius = 10
            self.playerLayer?.cornerRadius = 10
            
            self.leadingConstraint.constant = 20
            self.bottomConstraint.constant = 25
                        
        }
        
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveLinear, animations: {
            
            self.playerView.superview?.layoutIfNeeded()
            
        }, completion: nil)
        
        
        self.playerView.layer.cornerRadius = 12
        self.playerLayer?.cornerRadius = 12
        self.avpController.view.layer.cornerRadius = 12
        avpController.view.layer.masksToBounds = true
        
    }
    
    
    
}
