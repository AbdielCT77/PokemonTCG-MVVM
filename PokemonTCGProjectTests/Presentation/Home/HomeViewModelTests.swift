//
//  HomeViewModelTests.swift
//  PokemonTCGProjectTests
//
//  Created by Abdiel CT MNC on 16/03/23.
//

import XCTest
@testable import PokemonTCGProject
import RxSwift
import RxCocoa
import RxBlocking

final class HomeViewModelTests: XCTestCase {
    
    var useCaseMock: HomeUseCaseMock!
    var viewModel: HomeViewModel!
    let bag = DisposeBag()
    
    override func setUp() {
        super.setUp()
        
        useCaseMock = HomeUseCaseMock()
        viewModel = HomeViewModel(homeUseCase: useCaseMock)
    }
    
    private func createInput(
        fetchList: Observable<Void> = Observable.just(()),
        loadMore: Observable<Void> = Observable.never(),
        search: Observable<String> = Observable.never()
    ) -> HomeViewModel.Input {
        return HomeViewModel.Input(
            fetchPokemonList: fetchList.asDriverOnErrorJustComplete(),
            loadMorePokemonList: loadMore.asDriverOnErrorJustComplete(),
            searchPokemon: search.asDriverOnErrorJustComplete()
        )
    }
    
    func test_transform_fetchList_useCaseEmitted() {
        //given
        let fetchList = PublishSubject<Void>()
        let input = createInput(fetchList: fetchList)
        let output = viewModel.transform(input: input)
        
        //when
        output.successFetchPokemonList.drive().disposed(by: bag)
        fetchList.onNext(())
        
        //then
        XCTAssert(useCaseMock.executeFetchJokeCardsList_Called)
    }
    
    func test_transform_fetchList_viewObject_size() {
        //given
        let fetchList = PublishSubject<Void>()
        let input = createInput(fetchList: fetchList)
        let output = viewModel.transform(input: input)
        var actualResult: HomeViewObject = []
        useCaseMock.executeFetchJokeCardsListValue = Observable.just([
            HomeViewObjectElement(),
            HomeViewObjectElement(),
            HomeViewObjectElement(),
            HomeViewObjectElement(),
        ])
        
        //when
        output.successFetchPokemonList.drive(onNext: { result in
            actualResult = result
        }).disposed(by: bag)
        fetchList.onNext()
        
        //then
        XCTAssert(useCaseMock.executeFetchJokeCardsList_Called)
        XCTAssertEqual(actualResult.count, 4)
    }
    
    func test_transform_loadMore_viewObject_sizeSum() {
        //given
        let loadMore = PublishSubject<Void>()
        let input = createInput(loadMore: loadMore)
        let output = viewModel.transform(input: input)
        var actualResult: HomeViewObject = []
        useCaseMock.executeFetchJokeCardsListValue = Observable.just([
            HomeViewObjectElement(),
        ])
        
        //when
        output.successLoadMore.drive(onNext: { result in
            actualResult = result
        }).disposed(by: bag)
        loadMore.onNext()
        
        //then
        XCTAssert(useCaseMock.executeFetchJokeCardsList_Called)
        XCTAssertEqual(actualResult.count, 1)
    }
    
    func test_transform_search_viewObject_sizeSum() {
        //given
        let searchList = PublishSubject<String>()
        let input = createInput(search: searchList)
        let output = viewModel.transform(input: input)
        var actualResult: HomeViewObject = []
        useCaseMock.executeFetchJokeCardsListValue = Observable.just([
            HomeViewObjectElement(),
            HomeViewObjectElement()
        ])
        
        //when
        output.successSearchPokemon.drive(onNext: { result in
            actualResult = result
        }).disposed(by: bag)
        searchList.onNext("hahaha")
        
        //then
        XCTAssert(useCaseMock.executeFetchJokeCardsList_Called)
        XCTAssertEqual(actualResult.count, 2)
    }
    
    
    func test_transform_EmitError_trackError() {
        // given
        let fetchList = PublishSubject<Void>()
        let input = createInput(fetchList: fetchList)
        let output = viewModel.transform(input: input)
        useCaseMock.executeFetchJokeCardsListValue = Observable.error(BaseError.networkError)
        
        // when
        output.successFetchPokemonList.drive().disposed(by: bag)
        output.error.drive().disposed(by: bag)
        fetchList.onNext(())
        let error = try! output.error.toBlocking().first()
        
        // then
        XCTAssertNotNil(error)
    }
}
