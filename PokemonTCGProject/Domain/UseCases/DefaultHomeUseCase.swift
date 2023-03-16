//
//  DefaultHomeUseCase.swift
//  PokemonTCGProject
//
//  Created by Abdiel CT MNC on 13/03/23.
//

import Foundation
import RxSwift

final class DefaultHomeUseCase: HomeUseCase {
    private let homeRepository: HomeRepository
    
    init() {
        self.homeRepository = DefaultHomeRepository()
    }
    
    func executeFetchJokeCardsList(page: Int, search: String) -> Observable<HomeViewObject> {
        return homeRepository.fetchHomeList(
            page: page,
            pageSize: GlobalVariables.pageSize,
            searchText: search
        )
    }
}

