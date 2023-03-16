//
//  DefaultDetailUseCase.swift
//  PokemonTCGProject
//
//  Created by Abdiel CT MNC on 14/03/23.
//

import Foundation
import RxSwift

final class DefaultDetailUseCase: DetailUseCase {
    private let homeRepository: HomeRepository
    private let detailRepository: DetailRepository
    
    init() {
        self.homeRepository = DefaultHomeRepository()
        self.detailRepository = DefaultDetailRepository()
    }
    
    func executeFetchCardsList(page: Int) -> Observable<HomeViewObject> {
        return homeRepository.fetchHomeList(
            page: page,
            pageSize: GlobalVariables.pageSizeDetail,
            searchText: ""
        )
    }
    
    func executeFetchCardDetail(
        pokemonId: String
    ) -> Observable<DetailViewObject> {
        return detailRepository.fetchDetailPokemon(pokemonId: pokemonId)
    }
}

