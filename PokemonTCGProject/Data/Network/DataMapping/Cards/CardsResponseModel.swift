//
//  CardsResponseModel.swift
//  PokemonTCGProject
//
//  Created by Abdiel CT MNC on 13/03/23.
//

import Foundation

// MARK: - CardsResponseModel
struct CardsResponseModel: Codable {
    let data: [Datum]?
    let page, pageSize, count, totalCount: Int?
}

// MARK: - Datum
struct Datum: Codable {
    let id, name: String?
    let supertype: String?
    let subtypes: [String]?
    let level: String?
    let hp: String?
    let types: [String]?
    let evolvesFrom: String?
    let abilities: [Ability]?
    let attacks: [Attack]?
    let weaknesses, resistances: [Resistance]?
    let retreatCost: [String]?
    let convertedRetreatCost: Int?
    let datumSet: DatumSet?
    let number, artist: String?
    let rarity: String?
    let nationalPokedexNumbers: [Int]
    let legalities: Legalities?
    let images: DatumImages?
    let tcgplayer: Tcgplayer?
    let cardmarket: Cardmarket?
    let evolvesTo: [String]?
    let flavorText: String?
    let rules: [String]?
    let regulationMark: String?

    enum CodingKeys: String, CodingKey {
        case id, name, supertype, subtypes, level, hp,
             types, evolvesFrom, abilities, attacks,
             weaknesses, resistances, retreatCost, convertedRetreatCost
        case datumSet = "set"
        case number, artist, rarity, nationalPokedexNumbers,
             legalities, images, tcgplayer, cardmarket, evolvesTo,
             flavorText, rules, regulationMark
    }
}

// MARK: - Ability
struct Ability: Codable {
    let name, text: String
    let type: String
}

// MARK: - Attack
struct Attack: Codable {
    let name: String?
    let cost: [String]?
    let convertedEnergyCost: Int?
    let damage, text: String?
}

// MARK: - Cardmarket
struct Cardmarket: Codable {
    let url: String?
    let updatedAt: String?
    let prices: [String: Double]?
}

// MARK: - Set
struct DatumSet: Codable {
    let id, name: String?
    let series: String?
    let printedTotal, total: Int?
    let legalities: Legalities?
    let ptcgoCode: String?
    let releaseDate, updatedAt: String?
    let images: SetImages?
}

// MARK: - SetImages
struct SetImages: Codable {
    let symbol, logo: String?
}

// MARK: - Legalities
struct Legalities: Codable {
    let unlimited: String
    let expanded, standard: String?
}


// MARK: - DatumImages
struct DatumImages: Codable, Equatable {
    let small, large: String?
}

// MARK: - Resistance
struct Resistance: Codable {
    let type: String?
    let value: String?
}

// MARK: - Tcgplayer
struct Tcgplayer: Codable {
    let url: String?
    let updatedAt: String?
    let prices: Prices?
}

// MARK: - Prices
struct Prices: Codable {
    let holofoil, reverseHolofoil,
        normal, the1StEditionHolofoil: The1_StEditionHolofoil?
    let unlimitedHolofoil: The1_StEditionHolofoil?

    enum CodingKeys: String, CodingKey {
        case holofoil, reverseHolofoil, normal
        case the1StEditionHolofoil = "1stEditionHolofoil"
        case unlimitedHolofoil
    }
}

// MARK: - The1_StEditionHolofoil
struct The1_StEditionHolofoil: Codable {
    let low, mid, high: Double?
    let market, directLow: Double?
}


extension CardsResponseModel {
    func toDomain() -> HomeViewObject {
        var cards = HomeViewObject()
        guard let data = data else { return cards}
        for data in data {
            cards.append(
                HomeViewObjectElement(
                    id: data.id ?? "",
                    name: data.name ?? "",
                    image: data.images?.small ?? "",
                    flavorText: data.flavorText ?? ""
                )
            )
        }
        return cards
    }
}
