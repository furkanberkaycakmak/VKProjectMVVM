//
//  ProductsViewController.swift
//  VKProjectMVVM
//
//  Created by Berkay ÇAKMAK on 10.04.2022.
//
import UIKit
import Floaty
import Synth

class ProductsViewController: BaseViewController {

    @IBOutlet weak var productsTableView: UITableView!
    let searchController = UISearchController(searchResultsController: nil)
    var refreshControl = UIRefreshControl()
    var filteredProducts: [Product] = []
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
      return searchController.isActive && !isSearchBarEmpty
    }
    
    var viewModel : ProductViewModel!
    var service : ProductServiceProtocol!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "VK Products"
        service = ProductService()
        viewModel = ProductViewModel(service: service)
        
        getProducts()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        productsTableView.addSubview(refreshControl)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Products"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        let floaty = Floaty()
        floaty.buttonColor = NeuUtils.baseColor
        floaty.plusColor = UIColor.white
        floaty.layer.cornerRadius = 25
        floaty.applyNeuStyle()
        guard let sb = storyboard else {
            return
        }
        let vc = sb.instantiateViewController(withIdentifier: "AddProductViewController") as! AddProductViewController
        floaty.addItem("Add Product", icon: UIImage(named: "add"), handler: { item in
            self.navigationController?.pushViewController(vc, animated: true)
            floaty.close()
        })
        
        self.view.addSubview(floaty)
    }
    
    @objc func refresh(_ sender: AnyObject) {
        getProducts()
    }
    
    func getProducts() {
        
        viewModel.getProducts { (done, err) in
            DispatchQueue.main.async { [weak self] in
                guard let strongSelf = self else {
                    return
                }
                strongSelf.refreshControl.endRefreshing()
                if done{
                    strongSelf.productsTableView.reloadData()
                    if strongSelf.viewModel.products.isEmpty {
                        strongSelf.productsTableView.tableFooterView = strongSelf.createErrorView(msg: "No Products have been listed yet.")
                    }
                }
                else{
                    if let err = err {
                        DispatchQueue.main.async { [weak self] in
                            guard let strongSelf = self else {
                                return
                            }
                            strongSelf.productsTableView.tableFooterView = strongSelf.createErrorView(msg: err)
                        }
                    }
                }
            }
        }
    }
   
    func select(product: Product) {
        
        guard let sb = storyboard else {
            return
        }
        let vc = sb.instantiateViewController(withIdentifier: "ProductDetailViewController") as! ProductDetailViewController
        vc.product = product
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func filterContentForSearchText(_ searchText: String) {
        filteredProducts = viewModel.products.filter { (product: Product) -> Bool in
            return (product.name?.lowercased().contains(searchText.lowercased()) ?? false || product.description?.lowercased().contains(searchText.lowercased()) ?? false)
      }
      productsTableView.reloadData()
    }

}

extension ProductsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        if let text = searchBar.text {
            filterContentForSearchText(text)
        }
    }
}
extension ProductsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
           return filteredProducts.count
         }
        return viewModel.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductsTableViewCell") as! ProductsTableViewCell
        let product : Product
        if isFiltering {
            product = filteredProducts[indexPath.row]
          } else {
            product = viewModel.products[indexPath.row]
          }
        
        cell.configure(product: product)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let product: Product
        if isFiltering {
            product = filteredProducts[indexPath.row]
        } else {
            product = viewModel.products[indexPath.row]
        }

       select(product: product)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: ""){(contextualAction,view,bool) in
            var product: Product
            if self.isFiltering {
                product = self.filteredProducts[indexPath.row]
            } else {
                product = self.viewModel.products[indexPath.row]
            }
            
            let alert = UIAlertController(title: "Are you sure want to delete", message: "You cannot undo this action", preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel){ action in }
            alert.addAction(cancelAction)
            
            let yesAction = UIAlertAction(title: "Yes", style: .destructive){ action in
    /*            func deleteProduct(at row: Int) {


                    let filteredProducts = self.filteredProducts[row]

                    self.productService.deleteProduct(with: filteredProducts.id) { [weak self] result in
                        switch result {
                        case .success:
                            self?.presentables.removeAll(where: {
                                $0 == filteredPresentable
                            })
                            self?.onEvent?(.productDeleted(row: row))
                            self?.state.switchToLoaded()
                        case .failure(let error):
                            self?.handleError(error)
                        }
                    }
                } */
                
            }
            alert.addAction(yesAction)
            
            self.present(alert, animated: true)
        }
        deleteAction.image = UIImage(named: "x.jpg")
        deleteAction.backgroundColor = UIColor(named: "ButtonColor")
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    
    
    
}



