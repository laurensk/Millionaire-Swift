//
//  AlertView.swift
//  Millionaire
//
//  Created by Laurens on 20.10.19.
//  Copyright © 2019 Laurens K. All rights reserved.
//

import UIKit

protocol AlertViewDelegate: class {
    func alertButtonTappedDelegate(_ buttonAction: String)
}

class AlertView: UIViewController {
    
    
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var alertColorBackgroundView: UIView!
    @IBOutlet weak var alertImageView: UIImageView!
    @IBOutlet weak var alertTitleLabel: UILabel!
    @IBOutlet weak var alertSubtitleTextView: UITextView!
    @IBOutlet weak var alertButton: UIButton!
    
    var delegate: AlertViewDelegate?
    var alertBackgroundColor: UIColor?
    var alertImageName: String?
    var alertTitle: String?
    var alertText: String?
    var alertButtonColor: UIColor?
    var alertButtonTitle: String?
    var alertButtonAction: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
        animateView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.layoutIfNeeded()
    }
    
    func setupView() {
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        self.alertColorBackgroundView.backgroundColor = alertBackgroundColor!
        self.alertImageView.image = UIImage(named: alertImageName!)
        self.alertTitleLabel.text = alertTitle
        self.alertSubtitleTextView.text = alertText
        self.alertButton.backgroundColor = alertButtonColor
        self.alertButton.setTitle(alertButtonTitle, for: .normal)
        
    }
    
    func animateView() {
        alertView.alpha = 0;
        self.alertView.frame.origin.y = self.alertView.frame.origin.y + 50
        UIView.animate(withDuration: 0.4, animations: { () -> Void in
            self.alertView.alpha = 1.0;
            self.alertView.frame.origin.y = self.alertView.frame.origin.y - 50
        })
    }
    
    @IBAction func alertButtonTapped(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        delegate?.alertButtonTappedDelegate(alertButtonAction!)
        
        
        
    }
    
}
