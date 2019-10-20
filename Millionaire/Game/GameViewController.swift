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

class GameViewController: UIViewController, AlertViewDelegate {
    
    var answerSound: AVAudioPlayer?
    var questionSound: AVAudioPlayer?
    var jokerSound: AVAudioPlayer?
    
    var question: Question?
    var randomQuestionAnswers: QuestionAnswers?

    @IBOutlet weak var logoImageView: UIImageView!
    
    
    @IBOutlet weak var fiftyFiftyJokerButton: UIButton!
    @IBAction func fiftyFiftyJokerButtonTapped(_ sender: Any) {
        
        if jokers[0].wasActivated {
            jokerWasAlreadyActivated()
        } else {
            jokers[0].wasActivated = true
            
            fiftyFiftyJoker()
            
        }
        
        jokerSetup()
        
    }
    
    @IBOutlet weak var audienceJokerButton: UIButton!
    @IBAction func audienceJokerButtonTapped(_ sender: Any) {
        
        if jokers[1].wasActivated {
            jokerWasAlreadyActivated()
        } else {
            jokers[1].wasActivated = true
            
            audienceJoker()
            
        }
        
        jokerSetup()
        
    }
    
    @IBOutlet weak var phoneJokerButton: UIButton!
    @IBAction func phoneJokerButtonTapped(_ sender: Any) {
        
        if jokers[2].wasActivated {
            jokerWasAlreadyActivated()
        } else {
            jokers[2].wasActivated = true
            
            phoneJoker()
            
        }
        
        jokerSetup()
        
    }
    
    
    @IBOutlet weak var questionNumberLabel: UILabel!
    
    @IBOutlet weak var questionTextView: UITextView!
    
    @IBOutlet weak var answerAView: UIView!
    @IBOutlet weak var answerBView: UIView!
    @IBOutlet weak var answerCView: UIView!
    @IBOutlet weak var answerDView: UIView!
    
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
        
        UIView.animate(withDuration: 0.5, delay: 0.3, options: UIView.AnimationOptions.curveEaseIn, animations: {
                // HERE
            self.logoImageView.transform = CGAffineTransform.identity.scaledBy(x: 2, y: 2) // Scale your image

            }) { (finished) in
                UIView.animate(withDuration: 1, animations: {

                    self.logoImageView.transform = CGAffineTransform.identity // undo in 1 seconds
                })
        }
        
        playQuestionSound()
        
        jokerSetup()
        
        loadQuestion()
        
    }
    
    func jokerSetup() {
        
        if jokers[0].wasActivated {
            fiftyFiftyJokerButton.alpha = 0.5
        }
        if jokers[1].wasActivated {
            audienceJokerButton.alpha = 0.5
        }
        if jokers[2].wasActivated {
            phoneJokerButton.alpha = 0.5
        }
        
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
        let buttonAction: String
        
        if answeredQuestions >= questions.count {
            
            buttonText = "Zum Ergebnis"
            buttonAction = "result"
            
        } else {
            
            buttonText = "Weiter"
            buttonAction = "next"
            
        }
        
        let storyboard = UIStoryboard(name: "Alert", bundle: nil)
        let correctAlert = storyboard.instantiateViewController(withIdentifier: "AlertView") as! AlertView
        correctAlert.providesPresentationContextTransitionStyle = true
        correctAlert.definesPresentationContext = true
        correctAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        correctAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        correctAlert.alertBackgroundColor = UIColor(red: 62.0/255.0, green: 191.0/255.0, blue: 0.0/255.0, alpha: 1)
        correctAlert.alertImageName = "correct"
        correctAlert.alertTitle = "Richtig!"
        correctAlert.alertText = "\(correctAnswerText)\nist die richtige Antwort!"
        correctAlert.alertButtonColor = UIColor(red: 167.0/255.0, green: 210.0/255.0, blue: 43.0/255.0, alpha: 1)
        correctAlert.alertButtonTitle = buttonText
        correctAlert.alertButtonAction = buttonAction
        correctAlert.delegate = self
        self.present(correctAlert, animated: true, completion: nil)
        
    }
    
    
    
    func incorrectAnswerAlert(_ correctAnswerText: String) {
        
        let buttonText: String
        let buttonAction: String
        
        if answeredQuestions >= questions.count {
            
            buttonText = "Zum Ergebnis"
            buttonAction = "result"
            
        } else {
            
            buttonText = "Weiter"
            buttonAction = "next"
            
        }
        
        let storyboard = UIStoryboard(name: "Alert", bundle: nil)
        let incorrectAlert = storyboard.instantiateViewController(withIdentifier: "AlertView") as! AlertView
        incorrectAlert.providesPresentationContextTransitionStyle = true
        incorrectAlert.definesPresentationContext = true
        incorrectAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        incorrectAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        incorrectAlert.alertBackgroundColor = UIColor(red: 189.0/255.0, green: 0.0/255.0, blue: 1.0/255.0, alpha: 1)
        incorrectAlert.alertImageName = "incorrect"
        incorrectAlert.alertTitle = "Falsch!"
        incorrectAlert.alertText = "Die richtige Antwort wäre gewesen:\n\(correctAnswerText)"
        incorrectAlert.alertButtonColor = UIColor(red: 210.0/255.0, green: 42.0/255.0, blue: 42.0/255.0, alpha: 1)
        incorrectAlert.alertButtonTitle = buttonText
        incorrectAlert.alertButtonAction = buttonAction
        incorrectAlert.delegate = self
        self.present(incorrectAlert, animated: true, completion: nil)
        
    }
    
    func alertButtonTappedDelegate(_ buttonAction: String) {
        
        jokerSound?.setVolume(0, fadeDuration: 3)
        answerSound?.setVolume(0, fadeDuration: 1)
        
        if buttonAction == "result" {
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let resultViewController = storyboard.instantiateViewController(withIdentifier: "ResultViewController") as! ResultViewController
            self.navigationController?.pushViewController(resultViewController, animated: true)
            
        } else if buttonAction == "next" {
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let gameViewController = storyboard.instantiateViewController(withIdentifier: "GameViewController") as! GameViewController
            self.navigationController?.pushViewController(gameViewController, animated: true)
            
        } else {
            
        }
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
    
    func jokerWasAlreadyActivated() {
        
        let storyboard = UIStoryboard(name: "Alert", bundle: nil)
        let jokerWasAlreadyActivatedAlert = storyboard.instantiateViewController(withIdentifier: "AlertView") as! AlertView
        jokerWasAlreadyActivatedAlert.providesPresentationContextTransitionStyle = true
        jokerWasAlreadyActivatedAlert.definesPresentationContext = true
        jokerWasAlreadyActivatedAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        jokerWasAlreadyActivatedAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        jokerWasAlreadyActivatedAlert.alertBackgroundColor = UIColor(red: 189.0/255.0, green: 0.0/255.0, blue: 1.0/255.0, alpha: 1)
        jokerWasAlreadyActivatedAlert.alertImageName = "incorrect"
        jokerWasAlreadyActivatedAlert.alertTitle = "Bereits eingesetzt"
        jokerWasAlreadyActivatedAlert.alertText = "Dieser Joker wurde bereits eingesetzt\nund ist nicht mehr verfügbar."
        jokerWasAlreadyActivatedAlert.alertButtonColor = UIColor(red: 210.0/255.0, green: 42.0/255.0, blue: 42.0/255.0, alpha: 1)
        jokerWasAlreadyActivatedAlert.alertButtonTitle = "Schließen"
        jokerWasAlreadyActivatedAlert.alertButtonAction = "close"
        jokerWasAlreadyActivatedAlert.delegate = self
        self.present(jokerWasAlreadyActivatedAlert, animated: true, completion: nil)
        
    }
    
    func fiftyFiftyJoker() {
        
        if let path = Bundle.main.path(forResource: "fiftyFifty.mp3", ofType: nil) {
            
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
        
        var correctAnswerId: Int = 100
        
        for i in 0..<question!.answers.count {
            if question?.answers[i].id == question?.correctAnswer {
                correctAnswerId = i
            }
        }
        
        print(correctAnswerId)
        
        var firstNumberToHide = Int.random(in: 0 ... 3)
        var secondNumberToHide = Int.random(in: 0 ... 3)
        
        while firstNumberToHide == correctAnswerId || secondNumberToHide == correctAnswerId || firstNumberToHide == secondNumberToHide {
            firstNumberToHide = Int.random(in: 0 ... 3)
            secondNumberToHide = Int.random(in: 0 ... 3)
        }
        
        print("hide1 \(firstNumberToHide)")
        print("hide2 \(secondNumberToHide)")
        
        if firstNumberToHide == 0 || secondNumberToHide == 0 {
            UIView.animate(withDuration: 2, animations: {
                self.answerAView.alpha = 0.3
            })
            answerAView.isUserInteractionEnabled = false
        }
        
        if firstNumberToHide == 1 || secondNumberToHide == 1 {
            UIView.animate(withDuration: 2, animations: {
                self.answerBView.alpha = 0.3
            })
            answerBView.isUserInteractionEnabled = false
        }
        
        if firstNumberToHide == 2 || secondNumberToHide == 2 {
            UIView.animate(withDuration: 2, animations: {
                self.answerCView.alpha = 0.3
            })
            answerCView.isUserInteractionEnabled = false
        }
        
        if firstNumberToHide == 3 || secondNumberToHide == 3 {
            UIView.animate(withDuration: 2, animations: {
                self.answerDView.alpha = 0.3
            })
            answerDView.isUserInteractionEnabled = false
        }
        
    }
    
    func audienceJoker() {
        
        if let path = Bundle.main.path(forResource: "audiencePhone.mp3", ofType: nil) {
            
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
        
        let storyboard = UIStoryboard(name: "Alert", bundle: nil)
        let audienceJokerAlert = storyboard.instantiateViewController(withIdentifier: "AlertView") as! AlertView
        audienceJokerAlert.providesPresentationContextTransitionStyle = true
        audienceJokerAlert.definesPresentationContext = true
        audienceJokerAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        audienceJokerAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        audienceJokerAlert.alertBackgroundColor = UIColor(red: 212.0/255.0, green: 114.0/255.0, blue: 2.0/255.0, alpha: 1)
        audienceJokerAlert.alertImageName = "MLogo_HTL"
        audienceJokerAlert.alertTitle = "Publikumsjoker"
        audienceJokerAlert.alertText = "Frage jemanden um dich,\num die Antwort zu erfahren."
        audienceJokerAlert.alertButtonColor = UIColor(red: 253.0/255.0, green: 145.0/255.0, blue: 21.0/255.0, alpha: 1)
        audienceJokerAlert.alertButtonTitle = "Erledigt"
        audienceJokerAlert.alertButtonAction = "close"
        audienceJokerAlert.delegate = self
        self.present(audienceJokerAlert, animated: true, completion: nil)
        
    }
    
    func phoneJoker() {
        
        if let path = Bundle.main.path(forResource: "audiencePhone.mp3", ofType: nil) {
            
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
        
        let storyboard = UIStoryboard(name: "Alert", bundle: nil)
        let phoneJokerAlert = storyboard.instantiateViewController(withIdentifier: "AlertView") as! AlertView
        phoneJokerAlert.providesPresentationContextTransitionStyle = true
        phoneJokerAlert.definesPresentationContext = true
        phoneJokerAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        phoneJokerAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        phoneJokerAlert.alertBackgroundColor = UIColor(red: 212.0/255.0, green: 114.0/255.0, blue: 2.0/255.0, alpha: 1)
        phoneJokerAlert.alertImageName = "MLogo_HTL"
        phoneJokerAlert.alertTitle = "Telefonjoker"
        phoneJokerAlert.alertText = "Frage uns,\num die Antwort zu erfahren."
        phoneJokerAlert.alertButtonColor = UIColor(red: 253.0/255.0, green: 145.0/255.0, blue: 21.0/255.0, alpha: 1)
        phoneJokerAlert.alertButtonTitle = "Erledigt"
        phoneJokerAlert.alertButtonAction = "close"
        phoneJokerAlert.delegate = self
        self.present(phoneJokerAlert, animated: true, completion: nil)
        
    }
    

}
