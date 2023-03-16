//
//  HomeUseCase.swift
//  PokemonTCGProject
//
//  Created by Abdiel CT MNC on 13/03/23.
//

import Foundation
import RxSwift

protocol HomeUseCase {
    func executeFetchJokeCardsList(page: Int, search: String) -> Observable<HomeViewObject>
}
