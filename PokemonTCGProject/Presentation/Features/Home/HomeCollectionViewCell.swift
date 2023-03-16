//
//  HomeCollectionViewCell.swift
//  PokemonTCGProject
//
//  Created by Abdiel CT MNC on 14/03/23.
//

import UIKit
import SnapKit

class HomeCollectionViewCell: BaseCollectionViewCell {
    
    private let pokemonImage : CustomImageView = {
        let image = addComponent.customImage(rounded: 0)
        image.backgroundColor = BaseColor.backgroundColor.color
        return image
    }()
    
    override func setupViews() {
        addSubview(pokemonImage)
    }
    
    override func setConstraintsView() {
        pokemonImage.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.width.equalTo(150)
            make.height.equalTo(200)
        }
    }
    
    func configureCell(data: HomeViewObjectElement) {
        pokemonImage.loadImageUsingUrlString(
            data.image,
            defaultImg: GlobalVariables.placeholderImage,
            completion: {(data) in },
            contentMode: .scaleAspectFill
        )
    }
}
