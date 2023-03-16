//
//  DetailViewController.swift
//  PokemonTCGProject
//
//  Created by Abdiel CT MNC on 14/03/23.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class DetailViewController: UIViewController {
    
    private lazy var tableView : UITableView = {
        let tableView = addComponent.tableView(dataSource: self, delegate: self)
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.registerCellClass(DetailHeaderViewCell.self)
        tableView.registerCellClass(DetailDesriptionViewCell.self)
        tableView.registerCellClass(DetailCardListViewCell.self)
        tableView.estimatedRowHeight = view.frame.height
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    private let imageLargeView = addComponent.view(addColor: .clear)
    private let imageLarge : CustomImageView = {
        let image = addComponent.customImage(rounded: 0)
        image.backgroundColor = BaseColor.clear.color
        return image
    }()
    
    var viewModel: DetailViewModel?
    private var loadMore = PublishSubject<Void>()
    private var detailSection: [DetailPokemonEnum] = [ .header, .desc, .cards]
    private var dataDetail: DetailViewObject?
    private var dataCards: HomeViewObject = []
    private var bag = DisposeBag()
    private var indexPath: IndexPath?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        bindViewModel()
    }
    
    private func setUI(){
        tableView.addBackgroundColor(addColor: .backgroundColor)
        view.addSubview(tableView)
        view.addSubview(imageLargeView)
        imageLargeView.addSubview(imageLarge)
        navigationController?.navigationBar.barTintColor = BaseColor.navigationColor.color
        setConstraint()
        showImageLarge(hide: true)
    }
    
    private func setConstraint() {
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.right.equalToSuperview()
            make.left.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        imageLargeView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.right.equalToSuperview()
            make.left.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        imageLarge.snp.makeConstraints { make in
            make.width.equalTo(self.view.bounds.width * 60 / 100)
            make.height.equalTo(self.view.bounds.height * 90 / 100)
            make.centerX.equalTo(self.view)
            make.centerY.equalTo(self.view)
        }
        
        
    }
    
    private func bindViewModel(){
        let input = DetailViewModel.Input(
            fetchData: Observable.just(()).asDriverOnErrorJustComplete(),
            loadMorePokemonList: loadMore.asDriverOnErrorJustComplete()
        )
        
        guard let output = viewModel?.transform(input: input) else { return }
        
        output.successLoadMore.drive(onNext: { viewObject in
            self.dataCards += viewObject
            self.updateCardList()
        }).disposed(by: bag)
        
        output.successFetchData.drive(onNext: { detail, list in
            self.dataDetail = detail
            self.dataCards = list
            self.title = detail.name
            self.setUpImageLarge()
            self.tableView.reloadData()
        }).disposed(by: bag)
        
        
        output.loading.drive(onNext: { isLoading in
            self.showLoading(isLoading: isLoading)
        }).disposed(by: bag)
        
        output.error.drive(onNext: { error in
            guard let error = error as? BaseError else { return }
            self.showToast(message: error.getError.getDesc())
        }).disposed(by: bag)
    }
    
    private func showImageLarge(hide: Bool){
        imageLargeView.isHidden = hide
    }
    
    private func updateCardList() {
        if let indexPath = self.indexPath {
            if let cell = self.tableView.cellForRow(
                at: indexPath
            ) as? DetailCardListViewCell {
            cell.configureData(data: self.dataCards)
               cell.collectionView.reloadData()
            }
        }
    }
    
    private func setUpImageLarge(){
        let imageTapped = UITapGestureRecognizer(
            target: self, action: #selector(imageViewTapped(_:))
        )
        if let imageDetail = dataDetail?.image.large {
            imageLarge.isUserInteractionEnabled = true
            imageLarge.addGestureRecognizer(imageTapped)
            imageLarge.loadImageUsingUrlString(
                imageDetail,
                defaultImg: GlobalVariables.placeholderImage,
                completion: {(data) in },
                contentMode: .scaleAspectFit
            )
        }
    }
    
    @objc func imageViewTapped(_ sender:AnyObject){
        showImageLarge(hide: true)
    }
}

extension DetailViewController: UITableViewDelegate,
                                UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return detailSection.count
    }
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        switch detailSection[section] {
        case .header:
            return (dataDetail != nil) ? 1 : 0
        case .desc:
            return (dataDetail != nil) ? 1 : 0
        case .cards:
            return (dataCards.count > 0) ? 1 : 0
        }
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        switch detailSection[indexPath.section] {
        case .header:
            let cell = DetailHeaderViewCell(
                style: UITableViewCell.CellStyle.subtitle,
                reuseIdentifier: DetailHeaderViewCell.identifier
            )
            cell.configure(image: self.dataDetail?.image.small ?? "")
            return cell
        case .desc:
            let cell = DetailDesriptionViewCell(
                style: UITableViewCell.CellStyle.subtitle,
                reuseIdentifier: DetailDesriptionViewCell.identifier
            )
            guard let detail = self.dataDetail else { return UITableViewCell() }
            cell.configure(data: detail)
            return cell
        case .cards:
            let cell = DetailCardListViewCell(
                style: UITableViewCell.CellStyle.subtitle,
                reuseIdentifier: DetailCardListViewCell.identifier
            )
            self.indexPath = indexPath
            cell.configureData(data: dataCards)
            cell.delegate = self
            return cell
        }
    }
    
    
    
    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        switch detailSection[indexPath.section] {
        case .header:
            return 240
        case .desc:
            return UITableView.automaticDimension
        case .cards:
            return 240
        }
    }
    
    func tableView(
        _ tableView: UITableView,
        viewForHeaderInSection section: Int
    ) -> UIView? {
        let headerView = addComponent.view(addColor: BaseColor.backgroundColor)
        return headerView
    }
    
    func tableView(
        _ tableView: UITableView,
        heightForHeaderInSection section: Int
    ) -> CGFloat {
        return 8
    }
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        switch detailSection[indexPath.section] {
        case .header:
            showImageLarge(hide: false)
        case .desc:
            break
        case .cards:
            break
        }
    }
}

extension DetailViewController: DetailCardSelectedDelegate {
    func loadCardsMore() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.loadMore.onNext()
        }
    }
    
    func detailCardTapped(data: DetailViewObject) {
        let vc = DetailViewController()
        vc.viewModel = DetailViewModel(detailVO: data)
        navigationController?.pushViewController(vc, animated: false)
    }
    
    
}
