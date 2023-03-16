//
//  DetailRepository.swift
//  PokemonTCGProject
//
//  Created by Abdiel CT MNC on 14/03/23.
//

import Foundation
import RxSwift

protocol DetailRepository {
    func fetchDetailPokemon(pokemonId: String) -> Observable<DetailViewObject>
}
