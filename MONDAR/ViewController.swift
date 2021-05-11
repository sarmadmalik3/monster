//
//  ViewController.swift
//  MONDAR
//
//  Created by Sarmad Malik on 29/04/2021.
//

import UIKit
import HGRippleRadarView
import MediaPlayer
import AVFoundation

class ViewController: UIViewController , AVAudioPlayerDelegate{

    //MARK:-IBOutlets
    @IBOutlet weak var imgPushToStart: UIImageView!
    @IBOutlet weak var rippleView: RippleView!
    
    //MARK:-Properties
    let raddarView = RadarView()
    var audioPlayer:AVAudioPlayer! = nil
    
    //MARK:-ViewController LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        rippleView.numberOfCircles = 0
        rippleView.diskColor = #colorLiteral(red: 0.1607843137, green: 0.7058823529, blue: 0.7019607843, alpha: 1)
        rippleView.diskRadius = 0.1
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handlePushToStart))
        rippleView.isUserInteractionEnabled = true
        rippleView.addGestureRecognizer(tapGesture)
        prepareAudio()
    }

    //MARK:-Selector
    @objc func handlePushToStart(){
        rippleView.isUserInteractionEnabled = false
        rippleView.stopAnimation()
        imgPushToStart.startShimmeringAnimation(animationSpeed: 1.4, direction: .leftToRight, repeatCount: 1000)
        audioPlayer.play()
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RaddarViewControlller")
        controller.modalTransitionStyle = .crossDissolve
        controller.modalPresentationStyle = .overFullScreen
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
//            self?.audioPlayer.stop()
            self?.rippleView.isUserInteractionEnabled = true
            self?.imgPushToStart.stopShimmeringAnimation()
            self?.present(controller, animated: true)
        }
    }
    
    //MARK:-Prepare seesion
    func prepareAudio(){
        guard let url = Bundle.main.url(forResource: "initialSound", withExtension: "mp3") else { return }
        do {
            //keep alive audio at background
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category(rawValue: convertFromAVAudioSessionCategory(AVAudioSession.Category.playback)))
        } catch{
            print("error in background play")
        }
        do {
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("error in audio session")
        }
        UIApplication.shared.beginReceivingRemoteControlEvents()
        audioPlayer = try? AVAudioPlayer(contentsOf: url)
        audioPlayer.delegate = self
        audioPlayer.prepareToPlay()
    }
    
    fileprivate func convertFromAVAudioSessionCategory(_ input: AVAudioSession.Category) -> String {
        return input.rawValue
    }
}
    


