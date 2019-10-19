//
//  MenuViewController.swift
//  Millionaire
//
//  Created by Laurens on 19.10.19.
//  Copyright © 2019 Laurens K. All rights reserved.
//

import UIKit
import SafariServices
import AVFoundation

class MenuViewController: UIViewController, SFSafariViewControllerDelegate {
    
    var introSound: AVAudioPlayer?

    @IBOutlet weak var htlLogoImageView: UIImageView!
    @IBOutlet weak var appLogoImageView: UIImageView!
    
    @IBAction func startButton(_ sender: Any) {
        
        self.introSound?.setVolume(0, fadeDuration: 1)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let gameViewController = storyboard.instantiateViewController(withIdentifier: "GameViewController") as! GameViewController
        self.navigationController?.pushViewController(gameViewController, animated: true)
        
    }
    
    
    @IBAction func aboutHtlButton(_ sender: Any) {
        
        let urlString = "http://www.htl-kaindorf.at"
        
        if let url = URL(string: urlString) {
            let vc = SFSafariViewController(url: url)
            vc.delegate = self
            present(vc, animated: true)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        htlLogoImageView.alpha = 0
        appLogoImageView.transform = CGAffineTransform(rotationAngle: 360)
        
        UIView.animate(withDuration: 3, animations: {
            self.htlLogoImageView.alpha = 1.0
        })
        
        UIView.animate(withDuration: 6, animations: {
            self.appLogoImageView.transform = CGAffineTransform(rotationAngle: 0)
        })
        
        if let path = Bundle.main.path(forResource: "intro.mp3", ofType: nil) {
            
            let url = URL(fileURLWithPath: path)

            do {
                introSound = try AVAudioPlayer(contentsOf: url)
                introSound?.play()
            } catch {
                print("couldn't load file")
            }
            
        } else {
            print("error playing sound")
        }
        
    }
    

}
