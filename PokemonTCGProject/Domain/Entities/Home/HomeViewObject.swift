//
//  HomeViewObject.swift
//  PokemonTCGProject
//
//  Created by Abdiel CT MNC on 13/03/23.
//

import Foundation

struct HomeViewObjectElement: Equatable {
    var id: String
    var name: String
    var image: String
    var flavorText: String
    
    init(
        id: String = "",
        name: String = "",
        image: String = "",
        flavorText: String = ""
    ) {
        self.id = id
        self.name = name
        self.image = image
        self.flavorText = flavorText
    }
    
    
    
}

typealias HomeViewObject = [HomeViewObjectElement]
