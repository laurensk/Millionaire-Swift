//
//  ResultViewController.swift
//  Millionaire
//
//  Created by Laurens on 19.10.19.
//  Copyright © 2019 Laurens K. All rights reserved.
//

import UIKit
import SafariServices
import AVFoundation

class ResultViewController: UIViewController, SFSafariViewControllerDelegate {
    
    var resultSound: AVAudioPlayer?

    @IBOutlet weak var resultIconImageView: UIImageView!
    
    @IBOutlet weak var resultBackgroundView: UIView!
    
    @IBOutlet weak var resultTextLabel: UILabel!
    
    @IBOutlet weak var correctQuestingsLabel: UILabel!
    
    @IBAction func playAgainButton(_ sender: Any) {
        
        self.resultSound?.setVolume(0, fadeDuration: 1)
        
        answeredQuestions = 0
        correctQuestings = 0
        
        jokers[0].wasActivated = false
        jokers[1].wasActivated = false
        jokers[2].wasActivated = false
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let gameViewController = storyboard.instantiateViewController(withIdentifier: "GameViewController") as! GameViewController
        self.navigationController?.pushViewController(gameViewController, animated: true)
        
    }
    
    
    @IBAction func abountHtlButton(_ sender: Any) {
        
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
        
        playSound()
        
        resultIconImageView.transform = CGAffineTransform(rotationAngle: 360)
        
        UIView.animate(withDuration: 3, animations: {
            self.resultIconImageView.transform = CGAffineTransform(rotationAngle: 0)
        })
        
        let positiveResult: Bool
        
        if correctQuestings < questions.count/2 {
            positiveResult = false
        } else if correctQuestings > questions.count/2 {
            positiveResult = true
        } else {
            positiveResult = false
        }
        
        if positiveResult {
            resultIconImageView.image = UIImage(named: "correct")
            resultBackgroundView.backgroundColor = UIColor(red: 62.0/255.0, green: 191.0/255.0, blue: 0.0/255.0, alpha: 1)
            resultTextLabel.text = "Gratulation!"
        } else {
            resultIconImageView.image = UIImage(named: "incorrect")
            resultBackgroundView.backgroundColor = UIColor(red: 189.0/255.0, green: 0.0/255.0, blue: 1.0/255.0, alpha: 1)
            resultTextLabel.text = "Schade!"
        }
        
        correctQuestingsLabel.text = "\(correctQuestings)/\(questions.count)"
        
    }
    
    func playSound() {
        
        if let path = Bundle.main.path(forResource: "result.mp3", ofType: nil) {
            
            let url = URL(fileURLWithPath: path)

            do {
                resultSound = try AVAudioPlayer(contentsOf: url)
                resultSound?.play()
            } catch {
                print("couldn't load file")
            }
            
        } else {
            print("error playing sound")
        }
        
    }

}
