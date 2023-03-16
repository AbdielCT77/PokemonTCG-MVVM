//
//  HomeViewModel.swift
//  PokemonTCGProject
//
//  Created by Abdiel CT MNC on 14/03/23.
//

import Foundation
import RxSwift
import RxCocoa

extension HomeViewModel: ViewModelType {
    struct Input {
        let fetchPokemonList: Driver<Void>
        let loadMorePokemonList: Driver<Void>
        let searchPokemon: Driver<String>
    }
    
    struct Output {
        let loading: Driver<Bool>
        let error: Driver<Error>
        let successFetchPokemonList: Driver<HomeViewObject>
        let successLoadMore: Driver<HomeViewObject>
        let successSearchPokemon: Driver<HomeViewObject>
    }
}

final class HomeViewModel: ObservableObject {
    private let homeUseCase: HomeUseCase
    let activityTracker = ActivityTracker()
    let errorTracker = ErrorTracker()
    private var nextPage = 1
    

    
    init(homeUseCase: HomeUseCase = DefaultHomeUseCase()) {
        self.homeUseCase = homeUseCase
    }
    
}

extension HomeViewModel {
    func transform(input: Input) -> Output {
        let fetchPokemonList = input.fetchPokemonList
            .flatMapLatest { _ in
                return self.homeUseCase
                    .executeFetchJokeCardsList(page: self.nextPage, search: "")
                    .trackActivity(self.activityTracker)
                    .trackError(self.errorTracker)
                    .asDriverOnErrorJustComplete()
            }
        let loadMore = input.loadMorePokemonList
            .map { _ -> () in
                return self.nextPage += 1
            }
            .flatMapLatest { _ in
                return self.homeUseCase
                    .executeFetchJokeCardsList(page: self.nextPage, search: "")
                    .trackActivity(self.activityTracker)
                    .trackError(self.errorTracker)
                    .asDriverOnErrorJustComplete()
            }
        
        let searchPokemon = input.searchPokemon
            .flatMapLatest { words in
                return self.homeUseCase
                    .executeFetchJokeCardsList(page: 1, search: words)
                    .trackActivity(self.activityTracker)
                    .trackError(self.errorTracker)
                    .asDriverOnErrorJustComplete()
            }
        
        return Output(
            loading: self.activityTracker.asDriver(),
            error: self.errorTracker.asDriver(),
            successFetchPokemonList: fetchPokemonList,
            successLoadMore: loadMore,
            successSearchPokemon: searchPokemon
        )
    }
}
