//
//  GameViewController.swift
//  Millionaire
//
//  Created by Laurens on 19.10.19.
//  Copyright © 2019 Laurens K. All rights reserved.
//

import UIKit
import AVFoundation

var answeredQuestions: Int = 0
var correctQuestings: Int = 0

class GameViewController: UIViewController {
    
    var answerSound: AVAudioPlayer?
    var questionSound: AVAudioPlayer?
    
    var question: Question?
    var randomQuestionAnswers: QuestionAnswers?

    @IBOutlet weak var logoImageView: UIImageView!
    
    @IBOutlet weak var questionNumberLabel: UILabel!
    
    @IBOutlet weak var questionTextView: UITextView!
    
    @IBOutlet weak var answerALabel: UILabel!
    @IBOutlet weak var answerBLabel: UILabel!
    @IBOutlet weak var answerCLabel: UILabel!
    @IBOutlet weak var answerDLabel: UILabel!
    
    @IBAction func answerAButton(_ sender: Any) {
        checkForCorrectAnswer(0)
    }
    
    @IBAction func answerBButton(_ sender: Any) {
        checkForCorrectAnswer(1)
    }
    
    @IBAction func answerCButton(_ sender: Any) {
        checkForCorrectAnswer(2)
    }
    
    @IBAction func answerDButton(_ sender: Any) {
        checkForCorrectAnswer(3)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        UIView.animate(withDuration: 0.5, delay: 0.5, options: UIView.AnimationOptions.curveEaseIn, animations: {
                // HERE
            self.logoImageView.transform = CGAffineTransform.identity.scaledBy(x: 2, y: 2) // Scale your image

            }) { (finished) in
                UIView.animate(withDuration: 1, animations: {

                    self.logoImageView.transform = CGAffineTransform.identity // undo in 1 seconds
                })
        }
        
        playQuestionSound()
        
        loadQuestion()
        
    }
    
    func loadQuestion() {
        
        question = questions[answeredQuestions]
        question?.answers.shuffle()
        
        questionNumberLabel.text = "Frage \(answeredQuestions + 1)/5"
        questionTextView.text = question?.question
        
        answerALabel.text = question?.answers[0].answer
        answerBLabel.text = question?.answers[1].answer
        answerCLabel.text = question?.answers[2].answer
        answerDLabel.text = question?.answers[3].answer
        
    }
    
    func checkForCorrectAnswer(_ clickedButton: Int) {
        
        let givenAnswerId = question?.answers[clickedButton].id
        let correctAnswerId = question?.correctAnswer
        
        var correctAnswerText: String = ""
        
        for answer in question!.answers {
            if answer.id == correctAnswerId {
                correctAnswerText = answer.answer
            }
        }
        
        if givenAnswerId == correctAnswerId {
            correctAnswer(correctAnswerText)
        } else {
            incorrectAnswer(correctAnswerText)
        }
        
    }
    
    func correctAnswer(_ correctAnswerText: String) {
        
        questionSound?.setVolume(0, fadeDuration: 1)
        playAnswerSound(true)
        
        answeredQuestions = answeredQuestions + 1
        correctQuestings = correctQuestings + 1
        
        correctAnswerAlert(correctAnswerText)
        
    }
    
    func incorrectAnswer(_ correctAnswerText: String) {
        
        questionSound?.setVolume(0, fadeDuration: 1)
        playAnswerSound(false)
        
        answeredQuestions = answeredQuestions + 1
        
        incorrectAnswerAlert(correctAnswerText)
        
    }
    
    func correctAnswerAlert(_ correctAnswerText: String) {
        
        let buttonText: String
        
        if answeredQuestions >= questions.count {
            
            buttonText = "Zum Ergebnis"
            
        } else {
            
            buttonText = "Weiter"
            
        }
        
        let alert = UIAlertController(title: "Richtig!", message: "\(correctAnswerText)\nist die richtige Antwort.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "\(buttonText)", style: .cancel, handler: { action in
            
            self.answerSound?.setVolume(0, fadeDuration: 1)
            
            if answeredQuestions >= questions.count {
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let resultViewController = storyboard.instantiateViewController(withIdentifier: "ResultViewController") as! ResultViewController
                self.navigationController?.pushViewController(resultViewController, animated: true)
                
                
            } else {
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let gameViewController = storyboard.instantiateViewController(withIdentifier: "GameViewController") as! GameViewController
                self.navigationController?.pushViewController(gameViewController, animated: true)
                
            }
            
            
        }))
        self.present(alert, animated: true)
        
    }
    
    func incorrectAnswerAlert(_ correctAnswerText: String) {
        
        let buttonText: String
        
        if answeredQuestions >= questions.count {
            
            buttonText = "Zum Ergebnis"
            
        } else {
            
            buttonText = "Weiter"
            
        }
        
        let alert = UIAlertController(title: "Falsch!", message: "Die richtige Antwort wäre gewesen:\n\(correctAnswerText)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "\(buttonText)", style: .cancel, handler: { action in
            
            self.answerSound?.setVolume(0, fadeDuration: 1)
            
            if answeredQuestions >= questions.count {
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let resultViewController = storyboard.instantiateViewController(withIdentifier: "ResultViewController") as! ResultViewController
                self.navigationController?.pushViewController(resultViewController, animated: true)
                
                
            } else {
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let gameViewController = storyboard.instantiateViewController(withIdentifier: "GameViewController") as! GameViewController
                self.navigationController?.pushViewController(gameViewController, animated: true)
                
            }
            
            
        }))
        self.present(alert, animated: true)
        
    }
    
    func playAnswerSound(_ correctAnswer: Bool) {
        
        var audioFile = ""
        
        if correctAnswer {
            audioFile = "correct.mp3"
        } else {
            audioFile = "incorrect.mp3"
        }
        
        if let path = Bundle.main.path(forResource: audioFile, ofType: nil) {
            
            let url = URL(fileURLWithPath: path)

            do {
                answerSound = try AVAudioPlayer(contentsOf: url)
                answerSound?.play()
            } catch {
                print("couldn't load file")
            }
            
        } else {
            print("error playing sound")
        }
        
    }
    
    func playQuestionSound() {
        
        if let path = Bundle.main.path(forResource: "question.mp3", ofType: nil) {
            
            let url = URL(fileURLWithPath: path)

            do {
                answerSound = try AVAudioPlayer(contentsOf: url)
                answerSound?.play()
            } catch {
                print("couldn't load file")
            }
            
        } else {
            print("error playing sound")
        }
        
    }
    

}
