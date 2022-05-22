//
//  LoginViewController.swift
//  VKProjectMVVM
//
//  Created by Berkay ÇAKMAK on 16.04.2022.
//

import UIKit
import Pastel
import Synth

class LoginViewController: BaseViewController {
    
    @IBOutlet weak var logoView: UIImageView!
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var softLoginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
    }
    
    //MARK: - Function for login button action with segue
    
    @IBAction func loginButtonClicked(_ sender: Any) {
        self.performSegue(withIdentifier: "toProducts", sender: nil)
    }
    
    //MARK: - Function for setting up the views

    private func setupViews() {
        
        
        NeuUtils.baseColor = UIColor.white
        let textColor = UIColor(red: 20/255.0, green: 10/255.0, blue: 20/255.0, alpha: 0.9)
        let textAttributes: [NSAttributedString.Key:Any] = [
            .foregroundColor: textColor,
            .kern: 0.65,
            .font: UIFont.systemFont(ofSize: 14, weight: .semibold)
        ]
        softLoginButton.applyNeuBtnStyle(type: .elevatedSoftRound, attributedTitle: NSAttributedString(string: "Login", attributes: textAttributes))
        
        pastelViewSetup()
    }
    
    //MARK: - Configuration for storyboard like instagram using "pastel"
    
    func pastelViewSetup() {
        let pastelView = PastelView(frame: view.bounds)
        pastelView.startPastelPoint = .bottomLeft
        pastelView.endPastelPoint = .topRight
        pastelView.animationDuration = 1.0
        pastelView.setColors([UIColor(red: 156/255, green: 39/255, blue: 176/255, alpha: 1.0),
                              UIColor(red: 255/255, green: 64/255, blue: 129/255, alpha: 1.0),
                              UIColor(red: 123/255, green: 31/255, blue: 162/255, alpha: 1.0),
                              UIColor(red: 32/255, green: 76/255, blue: 255/255, alpha: 1.0),
                              UIColor(red: 32/255, green: 158/255, blue: 255/255, alpha: 1.0),
                              UIColor(red: 90/255, green: 120/255, blue: 127/255, alpha: 1.0),
                              UIColor(red: 58/255, green: 255/255, blue: 217/255, alpha: 1.0)])
        
        pastelView.startAnimation()
        view.insertSubview(pastelView, at: 0)
    }
}
