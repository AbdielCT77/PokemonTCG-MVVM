//
//  DetailHeaderViewCell.swift
//  PokemonTCGProject
//
//  Created by Abdiel CT MNC on 14/03/23.
//

import Foundation
import SnapKit

class DetailHeaderViewCell: BaseTableViewCell {
    
    private let cardImage : CustomImageView = {
        let image = addComponent.customImage(rounded: 0)
        image.backgroundColor = BaseColor.white.color
        return image
    }()
    
    override func prepareView() {
        addBackgroundColor(addColor: BaseColor.backgroundColor)
        addSubview(cardImage)
    }
    
    override func setConstraintsView() {
        cardImage.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(180)
            make.height.equalTo(240)
            make.centerX.equalTo(self.contentView)
        }
    }
    
    func configure(image: String) {
        cardImage.loadImageUsingUrlString(
            image,
            defaultImg: GlobalVariables.placeholderImage,
            completion: {(data) in },
            contentMode: .scaleAspectFill
        )
    }
}
