//
//  Extension + UIViewController.swift
//  PokemonTCGProject
//
//  Created by Abdiel CT MNC on 13/03/23.
//

import UIKit

extension UIView {
    func addShadow(corner: CGFloat, offset: CGSize){
        self.layer.cornerRadius = corner
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = 5.5
        self.layer.shadowOpacity = 0.2
        self.layer.masksToBounds = false
    }
    
    func borderView(
        lineWidth: CGFloat, cornerRadius: CGFloat,
        lineColor: BaseColor, isShadow: Bool
    ) {
        layer.borderWidth = lineWidth
        layer.borderColor = lineColor.color.cgColor
        layer.masksToBounds = true
        layer.cornerRadius = cornerRadius
        if isShadow {
            layer.masksToBounds = false
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOffset = CGSize(width: 0, height: 2.0)
            layer.shadowRadius = 5.5
            layer.shadowOpacity = 0.1
            layer.shadowPath = UIBezierPath(
                roundedRect:self.bounds,
                cornerRadius:self.layer.cornerRadius
            ).cgPath
        }
    }
    
    func roundedView(cornerRadius: CGFloat, bgColor: BaseColor, isShadow: Bool){
        backgroundColor = bgColor.color
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.clear.cgColor
        layer.masksToBounds = true
        layer.cornerRadius = cornerRadius
        if isShadow {
            layer.masksToBounds = false
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOffset = CGSize(width: 0, height: 2.0)
            layer.shadowRadius = 5.5
            layer.shadowOpacity = 0.1
            layer.shadowPath = UIBezierPath(
                roundedRect:self.bounds,
                cornerRadius:self.layer.cornerRadius
            ).cgPath
        }
    }
    
    func setGradientBackground(topColor: BaseColor, bottomColor: BaseColor) {
        let colorTop =  topColor.color.cgColor
        let colorBottom = bottomColor.color.cgColor
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [ colorTop, colorBottom]
        gradientLayer.locations = [ 0.0, 1.0]
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func addBackgroundColor(addColor: BaseColor) {
        self.backgroundColor = addColor.color
    }
}
