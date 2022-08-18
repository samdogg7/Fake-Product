//
//  ProductTableviewCell.swift.swift
//  Practice-Starbucks-App
//
//  Created by Sam Doggett on 11/26/21.
//

import Foundation
import UIKit

class ProductTableviewCell : UITableViewCell {
    
    // MARK: - Properties
    
    // Using a closure we can setup the `mainStack` in a consolidated location
    // This provides many advantages when working w/ a team because it improves readability
    private lazy var mainStack: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 20
        // NOTE:
        // If you are laying a view out programmatically, you must
        // set `translatesAutoresizingMaskIntoConstraints` to false
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    // You may note that all of these UI elements are created with as a `lazy var`
    // Recommend reading about `lazy var` here:
    // https://www.hackingwithswift.com/example-code/language/what-are-lazy-variables
    private lazy var thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private lazy var chevronImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.tintColor = .link
        return imageView
    }()
    
    // We can't reference `chevronImageView` before the whole class is initialized.
    // As a result, `chevronImageViewWidthAnchor` needs to be `lazy` so we reference `chevronImageView`
    // when the view is done initializing.
    //
    // This is not necessarily a common thing, but when working with UIKit programmatically, good to know.
    private lazy var chevronImageViewWidthAnchor: NSLayoutConstraint = {
        let constraint = chevronImageView.widthAnchor.constraint(equalToConstant: 30)
        constraint.isActive = true
        return constraint
    }()

    // The class that creates this tableview cell will set these properties
    // `didSet` is triggered whenever `title` is changed
    public var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    // `didSet` is triggered whenever `thumbnailImage` is changed
    public var thumbnailImage: UIImage? {
        didSet {
            thumbnailImageView.image = thumbnailImage
        }
    }
    
    // MARK: - Lifecycle Methods
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // ----------------------------
        // Before laying out your subviews, you MUST add your views to the primary view.
        // ----------------------------
        // Add stack to the UITableView's primary view, `contentView`
        contentView.addSubview(mainStack)
        // Add subviews to main stack using `addArrangedSubview`
        mainStack.addArrangedSubview(thumbnailImageView)
        mainStack.addArrangedSubview(titleLabel)
        mainStack.addArrangedSubview(chevronImageView)
    }
    
    // This prevents this class from being used in an interface builder
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // ----------------------------
    // Programatic auto layout tips
    // ----------------------------
    // Layout all views in `layoutSubviews()` (or `didLayoutSubviews()` when laying out in a `UIViewController`)
    //
    //
    // IMPORTANT NOTE:
    //
    // If you are laying a view out programmatically, you must set
    // `translatesAutoresizingMaskIntoConstraints` to false.
    //
    // mainStack.translatesAutoresizingMaskIntoConstraints = false is set above allowing us
    // to lay it out below....
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // ----------------------------
        // One way to layout subviews:
        // ----------------------------
        // mainStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        // mainStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        // mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        // mainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        
        
        // Second way to layout subviews that I prefer:
        // ----------------------------
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            mainStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            mainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
        
        // ----------------------------
        // Both approach 1 and 2 work the same. All a matter of preference. I find second a little more human readable.
        // ----------------------------
        
        // ----------------------------
        // Advanced tips
        // ----------------------------
        
        // ----------------------------
        // Note: you can store constraints as instance properties and later change them.
        // This is useful when creating dynamic views that need to change in size.
        // ----------------------------
        // For example make size go from 30 -> 50
        // chevronImageViewWidthAnchor.constant = 50
        
        // ----------------------------
        // You could also replace the instance property, BUT it is important to disable
        // the previous constraint before replacing it and activating new one.
        // ----------------------------
        // 1. Disable previous anchor
        // chevronImageViewWidthAnchor.isActive = false
        // 2. Replace old constraint
        // chevronImageViewWidthAnchor = chevronImageView.widthAnchor.constraint(equalTo: mainStack, multiplier: 0.1) // This is mainStack width * 0.1
        // 3. Activate new constraint
        // chevronImageViewWidthAnchor.isActive = true
    }
}
