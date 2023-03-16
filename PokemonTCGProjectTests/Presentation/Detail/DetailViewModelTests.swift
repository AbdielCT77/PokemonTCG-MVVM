//
//  DetailViewModelTests.swift
//  PokemonTCGProjectTests
//
//  Created by Abdiel CT MNC on 16/03/23.
//

import XCTest
@testable import PokemonTCGProject
import RxSwift
import RxCocoa
import RxBlocking

final class DetailViewModelTests: XCTestCase {
    
    var useCaseMock: DetailUseCaseMock!
    var viewModel: DetailViewModel!
    let bag = DisposeBag()
    
    override func setUp() {
        super.setUp()
        
        useCaseMock = DetailUseCaseMock()
        viewModel = DetailViewModel(
            detailVO: DetailViewObject(),
            useCase: DetailUseCaseMock()
        )
    }
    
    private func createInput(
        fetchData: Observable<Void> = Observable.just(()),
        loadMore: Observable<Void> = Observable.never()
    ) -> DetailViewModel.Input {
        return DetailViewModel.Input(
            fetchData: fetchData.asDriverOnErrorJustComplete(),
            loadMorePokemonList: loadMore.asDriverOnErrorJustComplete()
        )
    }
    
    func test_transform_fetchDataDetail_useCaseEmitted() {
        //given
        let fetchData = PublishSubject<Void>()
        let input = createInput(fetchData: fetchData)
        let output = viewModel.transform(input: input)
        
        //when
        output.successFetchData.drive().disposed(by: bag)
        fetchData.onNext()
        
        //then
        XCTAssert(useCaseMock.executeFetchCardDetail_Called)
    }
    
    func test_transform_fetchData_viewObject() {
        //given
        let fetchData = PublishSubject<Void>()
        let input = createInput(fetchData: fetchData)
        let output = viewModel.transform(input: input)
        let expectedResult_detail = DetailViewObject()
        let expectedResult_list = HomeViewObject()
        var actualResult_detail: DetailViewObject?
        var actualResult_list: HomeViewObject?
        
        //when
        output.successFetchData.drive(onNext: { result in
            actualResult_detail = result.0
            actualResult_list = result.1
        }).disposed(by: bag)
        fetchData.onNext()
        
        //then
        XCTAssertEqual(actualResult_detail, expectedResult_detail)
        XCTAssertEqual(actualResult_list, expectedResult_list)
    }
    
    func test_transform_EmitError_trackError() {
        // given
        let fetchList = PublishSubject<Void>()
        let input = createInput(fetchData: fetchList)
        let output = viewModel.transform(input: input)
        useCaseMock.executeFetchCardsList_Value = Observable.error(BaseError.networkError)
        
        // when
        output.successFetchData.drive().disposed(by: bag)
        output.error.drive().disposed(by: bag)
        fetchList.onNext(())
        let error = try! output.error.toBlocking().first()
        
        // then
        XCTAssertNotNil(error)
    }

    
}
