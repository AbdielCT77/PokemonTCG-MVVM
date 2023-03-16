//
//  ComponentView.swift
//  PokemonTCGProject
//
//  Created by Abdiel CT MNC on 13/03/23.
//

import Foundation
import UIKit

public var addComponent: IComponentView {
    struct Singleton {
        static let instance = ComponentView()
    }
    return Singleton.instance
}


public protocol IComponentView {
    func label(
        id: String, text: String, font: UIFont,
        addColor: BaseColor, align: NSTextAlignment
    ) -> UILabel
    func image(
        id: String, image: UIImage
    ) -> UIImageView
    func view(
        addColor: BaseColor
    ) -> UIView
    func textField(
        id: String, placeholder: String,
        fontSize: CGFloat
    ) -> UITextField
    func buttonCustomFont(
        id: String, title: String, corner: CGFloat, bgColor: BaseColor,
        textColor: BaseColor, isBorder: Bool,
        fontSize: CGFloat, borderColor: BaseColor
    ) -> UIButton
    func tableView(
        dataSource: UITableViewDataSource,
        delegate: UITableViewDelegate
    ) -> UITableView
    func textView(
        id: String, size: CGFloat,
        addColor: BaseColor, align: NSTextAlignment
    ) -> UITextView
    func stackView(
        views: [UIView], axis: NSLayoutConstraint.Axis, spacing: CGFloat
    ) -> UIStackView
    func customImage(
        rounded: CGFloat
    ) -> CustomImageView
    func circularImage(
        id: String, background: BaseColor
    ) -> UIImageView
    func imageFromFramework(
        id: String, image: String, className: AnyClass
    ) -> UIImageView
    func searchBar(
        placeHolder: String
    ) -> UISearchBar
    func collectionView() -> UICollectionView
    func collectionView(
        id: String,
        delegate: UICollectionViewDelegateFlowLayout,
        datasource: UICollectionViewDataSource,
        scrollDirection: UICollectionView.ScrollDirection,
        isEstimatedItemSize: Bool
    ) -> UICollectionView

}


open class ComponentView: IComponentView {
    public func circularImage(
        id: String,
        background: BaseColor
    ) -> UIImageView {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.accessibilityIdentifier = "image_identifier_\(id)"
        imageView.contentMode = .scaleAspectFit
        imageView.layer.borderColor = background.color.cgColor
        imageView.layer.masksToBounds = false
        imageView.layer.borderWidth = 2
        imageView.layer.cornerRadius = imageView.frame.height/2
        imageView.clipsToBounds = true
        return imageView
    }
    
    public func imageFromFramework(id: String, image: String, className: AnyClass) -> UIImageView {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.accessibilityIdentifier = "image_identifier_\(id)"
        imageView.image = UIImage(named: image, in: Bundle(for: className), compatibleWith: nil)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
    
    
    
    public func label(
        id: String, text: String, font: UIFont,
        addColor: BaseColor, align: NSTextAlignment
    ) -> UILabel {
        let label = UILabel(frame: .zero)
        label.textColor = addColor.color
        label.accessibilityIdentifier = "label_identifier_\(id)"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = font
        label.textAlignment = align
        label.lineBreakMode = .byWordWrapping
        label.text = text
        return label
    }
    
    public func image(id: String, image: UIImage) -> UIImageView {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.accessibilityIdentifier = "image_identifier_\(id)"
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
    
    public func customImage(rounded: CGFloat) -> CustomImageView {
        let imageView: CustomImageView = CustomImageView(frame: CGRect.zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        if rounded > 0 {
            imageView.layer.borderColor = UIColor.white.cgColor
            imageView.layer.masksToBounds = true
            imageView.layer.borderWidth = 0
            imageView.layer.cornerRadius = rounded
        }
        return imageView
    }
    
    public func view(addColor: BaseColor) -> UIView {
        let view = UIView(frame: .zero)
        view.backgroundColor = addColor.color
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
   
    public func textField(id: String, placeholder: String, fontSize: CGFloat) -> UITextField {
        let textfield: UITextField  = UITextField()
        textfield.accessibilityIdentifier = "textField_identifier_\(id)"
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.placeholder = placeholder
        textfield.textAlignment = .left
        textfield.autocorrectionType = .no
        textfield.autocapitalizationType = .none
        return textfield
    }
    
    
    public func buttonCustomFont(
        id: String, title: String, corner: CGFloat, bgColor: BaseColor,
        textColor: BaseColor, isBorder: Bool, fontSize: CGFloat,
        borderColor: BaseColor
    ) -> UIButton {
        let button: UIButton = UIButton()
        button.accessibilityIdentifier = "button_identifier_\(id)"
        button.setTitle(title, for: .normal)
        button.layer.cornerRadius = corner
        button.addBackgroundColor(addColor: bgColor)
        button.setTitleColor(textColor.color, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: fontSize)
        button.setTitleColor(.lightGray, for: .highlighted)
        button.translatesAutoresizingMaskIntoConstraints = false
        if isBorder {
            button.layer.borderColor = borderColor.color.cgColor
            button.layer.masksToBounds = true
            button.layer.borderWidth = 1.0
        }
        return button
    }
    
    public func tableView(
        dataSource: UITableViewDataSource,
        delegate: UITableViewDelegate
    ) -> UITableView {
        let tableView: UITableView = UITableView()
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.addBackgroundColor(addColor: .white)
        tableView.dataSource = dataSource
        tableView.delegate = delegate
        return tableView
    }
    
    public func textView(id: String, size: CGFloat, addColor: BaseColor, align: NSTextAlignment) -> UITextView {
        let textView:UITextView = UITextView()
        textView.addBackgroundColor(addColor: .clear)
        textView.accessibilityIdentifier = "textView_identifier_\(id)"
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textColor = addColor.color
        textView.textAlignment = align
        return textView
    }
    
    public func stackView(views: [UIView],
                          axis: NSLayoutConstraint.Axis,
                          spacing: CGFloat = 0) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = axis
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = spacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }
    
    public func searchBar(
        placeHolder: String
    ) -> UISearchBar {
        let searchBar:UISearchBar = UISearchBar()
        searchBar.searchBarStyle = UISearchBar.Style.default
        searchBar.placeholder = " Search..."
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.barTintColor = BaseColor.navigationColor.color
        searchBar.setTextFieldColor(BaseColor.white.color)
        searchBar.setIconColor(BaseColor.white.color)
        searchBar.tintColor = BaseColor.white.color
        
        return searchBar
    }
    
    public func collectionView() -> UICollectionView{
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(
            frame: .zero, collectionViewLayout: layout
        )
        return collection
    }
    
    public func collectionView(
        id: String,
        delegate: UICollectionViewDelegateFlowLayout,
        datasource: UICollectionViewDataSource,
        scrollDirection: UICollectionView.ScrollDirection,
        isEstimatedItemSize: Bool
    ) -> UICollectionView{
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = scrollDirection
        if isEstimatedItemSize{
            layout.estimatedItemSize = CGSize(width: 1, height: 1)
        }
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.dataSource = datasource
        collection.delegate = delegate
        collection.accessibilityIdentifier = "collection_identifier_\(id)"
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.contentInset = UIEdgeInsets(
            top: 0, left: 0, bottom: 0, right: 0
        )
        collection.scrollIndicatorInsets = UIEdgeInsets(
            top: 0, left: 0, bottom: 0, right: 0
        )
        collection.addBackgroundColor(addColor: .white)
        return collection
    }
}
