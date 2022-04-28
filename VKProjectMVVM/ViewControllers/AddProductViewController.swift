//
//  AddProductViewController.swift
//  VKProjectMVVM
//
//  Created by Berkay ÇAKMAK on 26.04.2022.
//

import UIKit

class AddProductViewController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var imageUrlTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addProductButtonClicked(_ sender: Any) {
    }
}
