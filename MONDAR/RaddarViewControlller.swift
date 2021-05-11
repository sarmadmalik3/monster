//
//  RaddarViewControlller.swift
//  MONDAR
//
//  Created by Sarmad Malik on 29/04/2021.
//

import UIKit
import HGRippleRadarView
import MediaPlayer
import AVFoundation
class RaddarViewControlller: UIViewController, AVAudioPlayerDelegate {

    //MARK:- IBOutlets
    @IBOutlet weak var radarView: RadarView!
    @IBOutlet weak var imgNoMonsterDetected: UIImageView!
    @IBOutlet weak var imgBorder: UIImageView!
    @IBOutlet weak var imgSearchForMonster: UIImageView!
    
    //MARK:-Properties
    var audioPlayer:AVAudioPlayer! = nil
    //MARK:-ViewController LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareAudio()
        imgNoMonsterDetected.isHidden = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 11) { [weak self] in
            self?.audioPlayer.stop()
            self?.prepareAudioForNomonsterDetected()
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.error)
            let tap = UITapGestureRecognizer(target: self, action: #selector(self?.handleTap))
            self?.imgNoMonsterDetected.isUserInteractionEnabled = true
            self?.imgNoMonsterDetected.addGestureRecognizer(tap)
            self?.imgBorder.isUserInteractionEnabled = true
            self?.imgBorder.addGestureRecognizer(tap)
            self?.radarView.stopAnimation()
            self?.imgSearchForMonster.stopShimmeringAnimation()
            self?.imgNoMonsterDetected.startShimmeringAnimation(animationSpeed: 1.4, direction: .leftToRight, repeatCount: 1000)
            self?.radarView.isHidden = true
            self?.imgNoMonsterDetected.isHidden = false
            
        }
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        imgSearchForMonster.startShimmeringAnimation(animationSpeed: 1.4, direction: .leftToRight, repeatCount: 1000)
    }
    
    fileprivate func convertFromAVAudioSessionCategory(_ input: AVAudioSession.Category) -> String {
        return input.rawValue
    }
    
    //MARK:-Prepare seesion
    func prepareAudio(){
        guard let url = Bundle.main.url(forResource: "radarSound", withExtension: "mp3") else { return }
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
        audioPlayer.play()

    }
    func prepareAudioForNomonsterDetected(){
        guard let url = Bundle.main.url(forResource: "no_monster_detected", withExtension: "mp3") else { return }
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
        audioPlayer.play()

    }
    @objc func handleTap(){
        imgNoMonsterDetected.stopShimmeringAnimation()
        self.dismiss(animated: true, completion: nil)
    }
}
