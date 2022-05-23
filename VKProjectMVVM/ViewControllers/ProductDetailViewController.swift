//
//  ProductDetailViewController.swift
//  VKProjectMVVM
//
//  Created by Berkay ÇAKMAK on 10.04.2022.
//

import UIKit
import Synth

class ProductDetailViewController: BaseViewController {
    
    @IBOutlet weak var productDetailTable: UITableView!
    
    @IBOutlet weak var addReview: UIButton!
    
    
    var product = Product()
    var service : ReviewService!
    var viewModel : ReviewViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
        service = ReviewService()
        if let id = product.id {
            viewModel = ReviewViewModel(productId: id, service: service)
            viewModel.getReviews { (res, err)  in
                DispatchQueue.main.async { [weak self] in
                    guard let strongSelf = self else {
                        return
                    }
                    
                    if res{
                        strongSelf.productDetailTable.reloadSections(IndexSet(integer: 1), with: .automatic)
                        if strongSelf.viewModel.reviews.isEmpty {
                            strongSelf.productDetailTable.tableFooterView = strongSelf.createErrorView(msg: "No reviews listed yet")
                        }
                    }
                    else{
                        if let err = err {
                            strongSelf.productDetailTable.tableFooterView = strongSelf.createErrorView(msg: err)
                        }
                    }
                }
            }
        }
        
    }
    
    //MARK: - Function when Add Review button clicked.
    
    @IBAction func addReviewTapped(_ sender: UIButton) {
        guard let sb = storyboard else {
            return
        }
        
        let vc = sb.instantiateViewController(identifier: "ReviewViewController") as! ReviewViewController
        vc.productId = product.id
        vc.delegate = self
        present(vc, animated: true)
    }
}

//MARK: - Delegate function for reviews

extension ProductDetailViewController: ReviewDelegate{
    func reviewSent(review: Review) {
        
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else {
                return
            }
            strongSelf.viewModel.reviews.append(review)
            strongSelf.productDetailTable.insertRows(at: [IndexPath(row: strongSelf.viewModel.reviews.count-1, section: 1)], with: .automatic)
            strongSelf.productDetailTable.tableFooterView = nil
        }
    }
}

extension ProductDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        else{
            return viewModel.reviews.count
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1{
            return "Reviews"
        } else {
            return product.name
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailTableViewCell") as! ProductDetailTableViewCell
            cell.configure(product: product)
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewTableViewCell") as! ReviewTableViewCell
            cell.configure(review: viewModel.reviews[indexPath.row])
            return cell
        }
    }
    //MARK: - Function for setting views on controller with "Synth"
    
    private func setupViews() {
        
        NeuUtils.baseColor = UIColor.white
        let textColor = UIColor(red: 20/255.0, green: 10/255.0, blue: 20/255.0, alpha: 0.9)
        let textAttributes: [NSAttributedString.Key:Any] = [
            .foregroundColor: textColor,
            .kern: 0.65,
            .font: UIFont.systemFont(ofSize: 14, weight: .semibold)
        ]
        addReview.applyNeuBtnStyle(type: .elevatedSoftRound, attributedTitle: NSAttributedString(string: "Add Review", attributes: textAttributes))
    }
    
}
