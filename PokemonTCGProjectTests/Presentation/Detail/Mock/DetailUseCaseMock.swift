//
//  DetailUseCaseMock.swift
//  PokemonTCGProjectTests
//
//  Created by Abdiel CT MNC on 16/03/23.
//

@testable import PokemonTCGProject
import RxSwift

class DetailUseCaseMock: DetailUseCase {
    
    var executeFetchCardDetail_Called = false
    var executeFetchCardDetail_Value: Observable<DetailViewObject> = Observable.just((DetailViewObject()))
    var executeFetchCardsList_Called = false
    var executeFetchCardsList_Value:Observable<HomeViewObject> = Observable.just([])
    
    func executeFetchCardDetail(pokemonId: String) -> Observable<DetailViewObject> {
        executeFetchCardDetail_Called = true
        return executeFetchCardDetail_Value
    }
    
    func executeFetchCardsList(page: Int) -> Observable<HomeViewObject> {
        executeFetchCardsList_Called = true
        return executeFetchCardsList_Value
    }
    
    
}
