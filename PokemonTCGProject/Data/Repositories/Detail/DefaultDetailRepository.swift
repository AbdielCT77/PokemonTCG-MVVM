//
//  DefaultDetailRepository.swift
//  PokemonTCGProject
//
//  Created by Abdiel CT MNC on 14/03/23.
//

import Foundation
import RxSwift
import RxCocoa

final class DefaultDetailRepository {
    private let apiService: NetworkService
    
    init() {
        self.apiService = DefaultNetworkService()
    }
}

extension DefaultDetailRepository: DetailRepository {
    func fetchDetailPokemon(
        pokemonId: String
    ) -> Observable<DetailViewObject> {
        return apiService.request(
            URL(string: URLs.cardsUrl + "/\(pokemonId)")!,
            .get,
            nil
        ).map { data , response in
            if let data = data {
                do {
                    let cardDetail = try JSONDecoder().decode(
                        CardDetailResponseModel.self,
                        from: data
                    )
                    return cardDetail.toDomain()
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
