//
//  ProductsTableViewCell.swift
//  VKProjectMVVM
//
//  Created by Berkay ÇAKMAK on 10.04.2022.
//

import UIKit
import Kingfisher
import Synth

class ProductsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productRating: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configure(product: Product) {
        
        productImage.kf.setImage(with: URL(string: product.imgUrl ?? ""))
        productDescription.text = product.description
        productName.text = product.name
        productPrice.text = "\(product.currency ?? "") \(String(product.price ?? 0.0))"
        productRating.text = product.getOverallRating()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}


extension Sequence where Element: AdditiveArithmetic {
    /// Returns the total sum of all elements in the sequence
    func sum() -> Element { reduce(.zero, +) }
}

