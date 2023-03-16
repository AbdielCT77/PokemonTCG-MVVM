//
//  CardDetailResponseModel.swift
//  PokemonTCGProject
//
//  Created by Abdiel CT MNC on 14/03/23.
//

import Foundation

struct CardDetailResponseModel: Codable {
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let id, name, supertype: String?
    let subtypes: [String]?
    let hp: String?
    let types, evolvesTo, rules: [String]?
    let evolvesFrom: String?
    let attacks: [Attack]?
    let weaknesses: [Weakness]?
    let retreatCost: [String]?
    let convertedRetreatCost: Int?
    let dataSet: DatumSet?
    let number, artist, rarity: String?
    let nationalPokedexNumbers: [Int]?
    let legalities: Legalities?
    let images: DatumImages?
    let tcgplayer: Tcgplayer?

    enum CodingKeys: String, CodingKey {
        case id, name, supertype, subtypes, hp, types, evolvesTo, rules,
             attacks, evolvesFrom, weaknesses, retreatCost, convertedRetreatCost
        case dataSet = "set"
        case number, artist, rarity, nationalPokedexNumbers,
             legalities, images, tcgplayer
    }
}

struct Weakness: Codable {
    let type, value: String
}

extension CardDetailResponseModel {
    func toDomain() -> DetailViewObject {
        return .init(
            id: data.id ?? "",
            name: data.name ?? "",
            image: data.images ?? DatumImages(small: "", large: ""),
            types: data.types ?? [],
            hp: data.hp ?? "",
            subType: data.subtypes ?? []
        )
    }
}
