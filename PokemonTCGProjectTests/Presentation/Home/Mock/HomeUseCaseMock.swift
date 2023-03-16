//
//  HomeUseCaseMock.swift
//  PokemonTCGProjectTests
//
//  Created by Abdiel CT MNC on 16/03/23.
//

@testable import PokemonTCGProject
import RxSwift

class HomeUseCaseMock: HomeUseCase {
    var executeFetchJokeCardsList_Called = false
    var executeFetchJokeCardsListValue:Observable<HomeViewObject> = Observable.just([])
    
    func executeFetchJokeCardsList(
        page: Int, search: String
    ) -> Observable<HomeViewObject> {
        executeFetchJokeCardsList_Called = true
        return executeFetchJokeCardsListValue
    }
}
