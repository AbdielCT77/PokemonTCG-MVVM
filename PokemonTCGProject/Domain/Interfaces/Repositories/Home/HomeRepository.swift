//
//  HomeRepository.swift
//  PokemonTCGProject
//
//  Created by Abdiel CT MNC on 13/03/23.
//

import Foundation
import RxSwift

protocol HomeRepository {
    func fetchHomeList(page: Int, pageSize: String, searchText: String) -> Observable<HomeViewObject>
}

