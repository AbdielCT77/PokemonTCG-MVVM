//
//  Extension + UITableView.swift
//  PokemonTCGProject
//
//  Created by Abdiel CT MNC on 14/03/23.
//

import UIKit

extension UITableView{
    func registerCellClass(_ cellClass: AnyClass) {
        let identifier = String.className(cellClass)
        self.register(cellClass, forCellReuseIdentifier: identifier)
    }
}
