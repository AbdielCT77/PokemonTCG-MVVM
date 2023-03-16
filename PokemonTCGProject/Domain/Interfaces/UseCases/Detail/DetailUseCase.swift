//
//  DetailUseCase.swift
//  PokemonTCGProject
//
//  Created by Abdiel CT MNC on 14/03/23.
//

import Foundation
import RxSwift

protocol DetailUseCase {
    func executeFetchCardDetail(pokemonId: String) -> Observable<DetailViewObject>
    func executeFetchCardsList(page: Int) -> Observable<HomeViewObject>
}
