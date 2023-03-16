//
//  BaseColor.swift
//  PokemonTCGProject
//
//  Created by Abdiel CT MNC on 13/03/23.
//

import UIKit

public enum BaseColor {
    case navigationColor, backgroundColor, textColor, white, clear, black
    
    var color : UIColor {
        switch self {
        case .navigationColor:
            return UIColor(red: 22, green: 27, blue: 34)
        case .backgroundColor:
            return UIColor(red: 26, green: 32, blue: 44)
        case .textColor:
            return UIColor.white
        case .white :
            return UIColor.white
        case .clear :
            return UIColor.clear
        case .black :
            return UIColor.black
        }
    }
}

