//
//  Product.swift
//  Practice-Starbucks-App
//
//  Created by Sam Doggett on 11/26/21.
//

import Foundation
import UIKit

// MARK: - Product

struct Product {
    var name: String
    var description: String
    var image: UIImage?
    
    init(name: String, description: String, image: UIImage?) {
        self.name = name
        self.description = description
        self.image = image
    }
}

// MARK: - Hashable

extension Product: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name + description)
    }
    
    // Hashable is used by `UITableViewDiffableDataSource` and `NSDiffableDataSourceSnapshot` used to compare cells
    static func == (lhs: Product, rhs: Product) -> Bool {
        return (lhs.name == rhs.name) && (lhs.description == rhs.description)
    }
    
}
