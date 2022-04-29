//
//  AddProductViewController.swift
//  VKProjectMVVM
//
//  Created by Berkay ÇAKMAK on 26.04.2022.
//

import UIKit
import Synth

class AddProductViewController: UIViewController {
    
    @IBOutlet var contentScrollView: UIScrollView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var imageUrlTextField: UITextField!
    @IBOutlet weak var softButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()

    }
    
    private func setupViews() {
        view.backgroundColor = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 0.95)
        contentScrollView.delaysContentTouches = false
        
        let textColor = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 0.9)
        let textAttributes: [NSAttributedString.Key:Any] = [
            .foregroundColor: textColor,
            .kern: 0.65,
            .font: UIFont.systemFont(ofSize: 14, weight: .semibold)
        ]
        softButton.applyNeuBtnStyle(type: .elevatedSoft, attributedTitle: NSAttributedString(string: "Add Product", attributes: textAttributes))
    }
    
    @IBAction func addProductButtonClicked(_ sender: Any) {
    }
}
