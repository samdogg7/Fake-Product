//
//  ProductViewController.swift
//  Practice-Starbucks-App
//
//  Created by Sam Doggett on 11/26/21.
//

import UIKit

enum ProductSection {
    case main // We only have one section
}

typealias ProductDatasource = UITableViewDiffableDataSource<ProductSection, Product>
typealias Snapshot = NSDiffableDataSourceSnapshot<ProductSection, Product>

class ProductViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.register(ProductTableviewCell.self, forCellReuseIdentifier: productTableviewCellId)
        return tableView
    }()
    
    private lazy var fakeData = [
        Product(name: "Coffee", description: "Hot coffee", image: UIImage(named: "Coffee")!),
        Product(name: "Cookie", description: "Chocolate chip cookie", image: UIImage(named: "Cookie")!),
        Product(name: "Panini", description: "Hot panini", image: UIImage(named: "Panini")!),
    ]
    
    private lazy var dataSource = makeDataSource()
    private let productTableviewCellId = "ProductTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Products"
        
        setupSubviews()
        applySnapshot()
    }
    
    func setupSubviews() {
        view.addSubview(tableView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    func makeDataSource() -> ProductDatasource {
        return UITableViewDiffableDataSource<ProductSection, Product>(tableView: tableView) { tableView, indexPath, itemIdentifier in
            let product = self.fakeData[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: self.productTableviewCellId, for: indexPath) as? ProductTableviewCell
            cell?.title = product.name
            cell?.thumbnailImage = product.image
            return cell
        }
    }
    
    func applySnapshot() {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(fakeData, toSection: .main)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension ProductViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ProductDetailViewController()
        vc.product = fakeData[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
