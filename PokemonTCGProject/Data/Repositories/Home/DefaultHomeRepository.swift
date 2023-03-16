//
//  DefaultHomeRepository.swift
//  PokemonTCGProject
//
//  Created by Abdiel CT MNC on 13/03/23.
//

import Foundation
import RxSwift
import RxCocoa

final class DefaultHomeRepository {
    private let apiService: NetworkService
    
    init() {
        self.apiService = DefaultNetworkService()
    }
}

extension DefaultHomeRepository: HomeRepository {
    
    func fetchHomeList(
        page: Int,
        pageSize: String,
        searchText: String
    ) -> Observable<HomeViewObject> {
        let parameters = searchText == "" ? [
            "page" : String(page),
            "pageSize" : pageSize,
        ] : [
            "pageSize" : pageSize,
            "q" : "name:" + searchText
        ]
        return apiService.request(
            URL(string: URLs.cardsUrl)!,
            .get,
            parameters
        ).map { data , response in
            if let data = data {
                do {
                    let cardList = try JSONDecoder().decode(
                        CardsResponseModel.self,
                        from: data
                    )
                    return cardList.toDomain()
                }
                catch {
                    throw BaseError.custom(
                        code: "0",
                        title: "Decode Failed",
                        desc: "Failed to decode Response"
                    )
                }
            }
            else {
                throw BaseError.custom(
                    code: "0",
                    title: "Data is Null",
                    desc: "No response data"
                )
            }
        }
    }
    
}


let a = "\"Hello world\""
