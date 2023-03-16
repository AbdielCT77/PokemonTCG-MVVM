//
//  CustomIndicatorCell.swift
//  PokemonTCGProject
//
//  Created by Abdiel CT MNC on 14/03/23.
//

import UIKit

class IndicatorCell: UICollectionViewCell {
    
    var indicator : UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        if #available(iOS 13.0, *) {
            view.style = .medium
        } else {
            view.style = .white
        }
        return view
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup(){
        contentView.addSubview(indicator)
        indicator.center = contentView.center
        indicator.hidesWhenStopped = true
    }
}
