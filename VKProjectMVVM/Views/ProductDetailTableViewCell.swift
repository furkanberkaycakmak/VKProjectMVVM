//
//  ProductDetailTableViewCell.swift
//  VKProjectMVVM
//
//  Created by Berkay ÇAKMAK on 10.04.2022.
//

import UIKit
import Kingfisher

class ProductDetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    //MARK: - Function that configures product table cell using "KingFisher"
    
    func configure(product: Product) {
        
        productImage.kf.setImage(with: URL(string: product.imgUrl ?? ""))
        productDescription.text = product.description
        productName.text = product.name
        productPrice.text = "\(product.currency ?? "") \(String(product.price ?? 0.0))"
    }
    
}
