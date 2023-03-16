//
//  DetailDescriptionViewCell.swift
//  PokemonTCGProject
//
//  Created by Abdiel CT MNC on 14/03/23.
//

import Foundation
import SnapKit

class DetailDesriptionViewCell: BaseTableViewCell {
    
    private let cardName = addComponent.label(
        id: "",
        text: "",
        font: .boldSystemFont(ofSize: 20),
        addColor: BaseColor.white,
        align: .left
    )
    
    private let cardType = addComponent.label(
        id: "",
        text: "",
        font: .systemFont(ofSize: 16),
        addColor: BaseColor.white,
        align: .left
    )
    
    private let cardSubType = addComponent.label(
        id: "",
        text: "",
        font: .systemFont(ofSize: 16),
        addColor: BaseColor.white,
        align: .left
    )
    
    private let flavorTextTitle = addComponent.label(
        id: "",
        text: "Flavor : ",
        font: .boldSystemFont(ofSize: 20),
        addColor: BaseColor.white,
        align: .left
    )
    
    private let cardFlavorText = addComponent.label(
        id: "",
        text: "",
        font: .italicSystemFont(ofSize: 16),
        addColor: BaseColor.white,
        align: .left
    )
    
    override func prepareView() {
        addSubview(cardName)
        addSubview(cardType)
        addSubview(cardSubType)
        addSubview(flavorTextTitle)
        addSubview(cardFlavorText)
        addBackgroundColor(addColor: .backgroundColor)
    }
    
    override func setConstraintsView() {
        cardName.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        cardType.snp.makeConstraints { make in
            make.top.equalTo(cardName.snp_bottomMargin).offset(8)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        cardSubType.snp.makeConstraints { make in
            make.top.equalTo(cardType.snp_bottomMargin).offset(8)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        flavorTextTitle.snp.makeConstraints { make in
            make.top.equalTo(cardSubType.snp_bottomMargin).offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        cardFlavorText.snp.makeConstraints { make in
            make.top.equalTo(flavorTextTitle.snp_bottomMargin).offset(8)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview()
        }
        
    }
    
    func configure(data: DetailViewObject) {
        cardName.text = data.name
        var type = ""
        var subtype = ""
        for (index, text) in data.types.enumerated() {
            type += index == data.types.count - 1 ?
            text : text + ", "
        }
        cardType.text = type + " (HP \(data.hp))"
        for (index, text) in data.subType.enumerated() {
            subtype += index == data.subType.count - 1 ?
            text : text + ", "
        }
        cardSubType.text = subtype
        cardFlavorText.text = data.flavorText == "" ? "-" : data.flavorText
    }
}

