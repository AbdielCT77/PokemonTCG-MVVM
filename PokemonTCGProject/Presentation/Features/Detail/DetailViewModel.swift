//
//  DetailViewModel.swift
//  PokemonTCGProject
//
//  Created by Abdiel CT MNC on 14/03/23.
//

import Foundation
import RxSwift
import RxCocoa

extension DetailViewModel: ViewModelType {
    struct Input {
        let fetchData: Driver<Void>
        let loadMorePokemonList: Driver<Void>
    }
    
    struct Output {
        let loading: Driver<Bool>
        let error: Driver<Error>
        let successFetchData: Driver<(DetailViewObject, HomeViewObject)>
        let successLoadMore: Driver<HomeViewObject>
    }
}

final class DetailViewModel: ObservableObject {
    private let detailUseCase: DetailUseCase
    let activityTracker = ActivityTracker()
    let errorTracker = ErrorTracker()
    private var detailVO: DetailViewObject
    private var nextPage = 1
    

    
    init(detailVO: DetailViewObject, useCase: DetailUseCase = DefaultDetailUseCase()) {
        self.detailUseCase = useCase
        self.detailVO = detailVO
    }
    
}

extension DetailViewModel {
    func transform(input: Input) -> Output {
        let fetchPokemonDetail = input.fetchData
            .flatMapLatest { _ in
                return self.detailUseCase
                    .executeFetchCardDetail(pokemonId: self.detailVO.id)
                    .trackActivity(self.activityTracker)
                    .trackError(self.errorTracker)
                    .asDriverOnErrorJustComplete()
            }
            .map { viewObject -> DetailViewObject in
                var vo = viewObject
                vo.flavorText = self.detailVO.flavorText
                return vo
            }
        
        let fetchPokemonList = input.fetchData
            .flatMapLatest { _ in
                return self.detailUseCase
                    .executeFetchCardsList(page: self.nextPage)
                    .trackActivity(self.activityTracker)
                    .trackError(self.errorTracker)
                    .asDriverOnErrorJustComplete()
            }
        
        let loadMorePokemonList = input.loadMorePokemonList
            .map { _ -> () in
                return self.nextPage += 1
            }
            .flatMapLatest { _ in
                return self.detailUseCase
                    .executeFetchCardsList(page: self.nextPage)
                    .trackActivity(self.activityTracker)
                    .trackError(self.errorTracker)
                    .asDriverOnErrorJustComplete()
            }
        
        let fetchData = Driver.combineLatest(
            fetchPokemonDetail,
            fetchPokemonList
        )
        
        return Output(
            loading: self.activityTracker.asDriver(),
            error: self.errorTracker.asDriver(),
            successFetchData: fetchData,
            successLoadMore: loadMorePokemonList
        )
    }
}
