//
//  ViewController.swift
//  MONDAR
//
//  Created by Sarmad Malik on 29/04/2021.
//

import UIKit
import HGRippleRadarView

class ViewController: UIViewController {

    @IBOutlet weak var imgPushToStart: UIImageView!
    @IBOutlet weak var rippleView: RippleView!
    
    let raddarView = RadarView()
    override func viewDidLoad() {
        super.viewDidLoad()
        rippleView.numberOfCircles = 0
        rippleView.diskColor = #colorLiteral(red: 0.1607843137, green: 0.7058823529, blue: 0.7019607843, alpha: 1)
        rippleView.diskRadius = 0.1
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handlePushToStart))
        rippleView.isUserInteractionEnabled = true
        rippleView.addGestureRecognizer(tapGesture)
    }

    @objc func handlePushToStart(){
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RaddarViewControlller")
        controller.modalTransitionStyle = .crossDissolve
        controller.modalPresentationStyle = .overFullScreen
        self.present(controller, animated: true)
    }
    
}
    


