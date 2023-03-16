//
//  BaseCollectionView.swift
//  PokemonTCGProject
//
//  Created by Abdiel CT MNC on 14/03/23.
//
import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
        self.setConstraintsView()
    }
    
    func setupViews() {
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.setupViews()
        self.setConstraintsView()
    }
    
    func setConstraintsView(){
        
    }
}
