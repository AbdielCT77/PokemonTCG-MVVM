//
//  Extension + UICollectionView.swift
//  PokemonTCGProject
//
//  Created by Abdiel CT MNC on 14/03/23.
//

import UIKit

extension UICollectionView{
    func registerCellClass(_ cellClass: AnyClass) {
        let identifier = String.className(cellClass)
        self.register(cellClass.self, forCellWithReuseIdentifier: identifier)
    }
    
    func registerFooter(_ footerClass: AnyClass) {
        let className = String(describing: footerClass)
        self.register(
            footerClass,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: className
        )
    }
}

extension UICollectionViewCell {
    func animateCell() {
        self.layer.transform = CATransform3DMakeScale(0.1,0.1,1)
        UIView.animate(withDuration: 0.3, animations: {
            self.layer.transform = CATransform3DMakeScale(1.05,1.05,1)
        },completion: { finished in
            UIView.animate(withDuration: 0.1, animations: {
                self.layer.transform = CATransform3DMakeScale(1,1,1)
            })
        })
    }
}
