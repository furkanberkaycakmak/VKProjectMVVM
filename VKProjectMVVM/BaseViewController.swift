//
//  ViewController.swift
//  VKProjectMVVM
//
//  Created by Berkay ÇAKMAK on 10.04.2022.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: - Alert Function
    
    func presentAlert(title: String, msg: String, handler: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: handler))
        present(alert, animated: true)
    }
    //MARK: -Error View Function
    
    func createErrorView(msg: String) -> UIView {
        
        let errorLabel = UILabel(frame: CGRect(x: 0,
                                               y: 0,
                                               width: view.frame.width,
                                               height: 100))
        errorLabel.text = msg
        errorLabel.backgroundColor = .clear
        errorLabel.numberOfLines = 0
        errorLabel.textAlignment = .center
        errorLabel.textColor = UIColor(named: "AppLabelColor")
        return errorLabel
    }
//MARK: - Spinner Function
    
    func createSpinner() -> UIView {
        let footer = UIView(frame: CGRect(x: 0,
                                          y: 0,
                                          width: view.frame.width,
                                          height: 100))
        footer.backgroundColor = UIColor(named: "AppColorDarkGray")
        let spinner = UIActivityIndicatorView()
        spinner.center = footer.center
        footer.addSubview(spinner)
        spinner.startAnimating()
        spinner.color = UIColor(named: "AppLabelColor")
        return footer
    }

}

