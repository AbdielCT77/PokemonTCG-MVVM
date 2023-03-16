//
//  DetailCardSelectedDelegate.swift
//  PokemonTCGProject
//
//  Created by Abdiel CT MNC on 16/03/23.
//

import Foundation

protocol DetailCardSelectedDelegate {
    func detailCardTapped(data: DetailViewObject)
    func loadCardsMore()
}
