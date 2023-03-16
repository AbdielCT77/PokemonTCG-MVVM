//
//  DetailViewObject.swift
//  PokemonTCGProject
//
//  Created by Abdiel CT MNC on 14/03/23.
//

import Foundation

struct DetailViewObject: Equatable {
    var id: String
    var name: String
    var image: DatumImages
    var types: [String]
    var subType: [String]
    var hp: String
    var flavorText: String
    
    
    init(
        id: String = "",
        name: String = "",
        image: DatumImages = DatumImages(small: "", large: ""),
        types: [String] = [],
        hp: String = "",
        flavorText: String = "",
        subType: [String] = []
    ) {
        self.id = id
        self.name = name
        self.image = image
        self.types = types
        self.hp = hp
        self.flavorText = flavorText
        self.subType = subType
    }
    
    static func == (lhs: DetailViewObject, rhs: DetailViewObject) -> Bool {
        return lhs.id == rhs.id &&
        lhs.name == rhs.name &&
        lhs.image == rhs.image &&
        lhs.types == rhs.types &&
        lhs.subType == rhs.subType &&
        lhs.hp == rhs.hp &&
        lhs.flavorText == rhs.flavorText
    }
}
