//
//  DetailCardsListViewCell.swift
//  PokemonTCGProject
//
//  Created by Abdiel CT MNC on 14/03/23.
//

import Foundation
import SnapKit

class DetailCardListViewCell: BaseTableViewCell {
    
    private let listTitle = addComponent.label(
        id: "",
        text: "Other Cards",
        font: .boldSystemFont(ofSize: 20),
        addColor: BaseColor.white,
        align: .left
    )
    
    lazy var collectionView : UICollectionView = {
        let collectionView = addComponent.collectionView(
            id: "collecitonViewCell",
            delegate: self,
            datasource: self,
            scrollDirection: .horizontal,
            isEstimatedItemSize: false
        )
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 00, left: 30, bottom: 0, right: 30)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.alwaysBounceHorizontal = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.registerCellClass(HomeCollectionViewCell.self)
        collectionView.addBackgroundColor(addColor: .backgroundColor)
        return collectionView
    }()
    
    var data: HomeViewObject = []
    var delegate: DetailCardSelectedDelegate?
    private var loadingView: IndicatorCell?
    
    override func prepareView() {
        self.contentView.addSubview(listTitle)
        self.contentView.addSubview(collectionView)
        addBackgroundColor(addColor: .backgroundColor)
        
    }
    
    override func setConstraintsView() {
        listTitle.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.right.equalToSuperview().offset(-16)
            make.left.equalToSuperview().offset(16)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(listTitle.snp_bottomMargin).offset(8)
            make.right.equalToSuperview()
            make.left.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func configureData(data: HomeViewObject) {
        self.data = data
        collectionView.reloadData()
    }
}

extension DetailCardListViewCell: UICollectionViewDataSource,
                                  UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return data.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String.className(HomeCollectionViewCell.self),
            for: indexPath
        ) as? HomeCollectionViewCell {
            cell.configureCell(data: data[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: 150, height: 200)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 10
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 10
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        let detail = data[indexPath.row]
        let detailVO = DetailViewObject(
            id: detail.id,
            name: detail.name,
            flavorText: detail.flavorText
        )
        delegate?.detailCardTapped(data: detailVO)
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x
        let sizeWidth = scrollView.contentSize.width
        let frameWidth = scrollView.frame.width
        if offsetX - 100 > (sizeWidth - frameWidth) && (offsetX) > 0 {
            delegate?.loadCardsMore()
        }
    }
}
