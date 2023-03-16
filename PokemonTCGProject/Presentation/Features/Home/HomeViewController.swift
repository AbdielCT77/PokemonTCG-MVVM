//
//  HomeViewController.swift
//  PokemonTCGProject
//
//  Created by Abdiel CT MNC on 13/03/23.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class HomeViewController: UIViewController {
    
    private lazy var collectionView : UICollectionView = {
        let collectionView = addComponent.collectionView(
            id: "collecitonViewCell",
            delegate: self,
            datasource: self,
            scrollDirection: .vertical,
            isEstimatedItemSize: false
        )
        collectionView.contentInset = UIEdgeInsets(
            top: 10, left: 20, bottom: 10, right: 20
        )
        collectionView.scrollIndicatorInsets = UIEdgeInsets(
            top: 00, left: 0, bottom: 0, right: 0
        )
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.registerCellClass(HomeCollectionViewCell.self)
        collectionView.registerFooter(IndicatorCell.self)
        collectionView.alwaysBounceVertical = false
        return collectionView
    }()
    
    private var searchBar = addComponent.searchBar(placeHolder: "Search ..")
    
    private var viewModel: HomeViewModel?
    private var data: HomeViewObject = []
    private var shownData: HomeViewObject = []
    private var fetchList = PublishSubject<Void>()
    private var loadMore = PublishSubject<Void>()
    private var bag = DisposeBag()
    private var loadingView: IndicatorCell?
    private var loading = true
    private let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        bindViewModel()
        configureSearch()
    }
    
    private func setUI(){
        title = "Pokemon TCG"
        view.addBackgroundColor(addColor: .backgroundColor)
        view.addSubview(collectionView)
        view.addSubview(searchBar)
        navigationController?.navigationBar.barTintColor = BaseColor.navigationColor.color
        collectionView.addBackgroundColor(addColor: .backgroundColor)
        
        searchBar.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.right.equalToSuperview()
            make.left.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp_bottomMargin).offset(8)
            make.bottom.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        collectionView.addSubview(refreshControl)
    }
    

    private func bindViewModel() {
        viewModel = HomeViewModel()
        let input = HomeViewModel.Input(
            fetchPokemonList: fetchList.asDriverOnErrorJustComplete(),
            loadMorePokemonList: loadMore.asDriverOnErrorJustComplete(),
            searchPokemon: searchBar.rx.text
                .orEmpty
                .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
                .distinctUntilChanged().asDriver(onErrorJustReturn: "")
        )
        
        fetchList.onNext()
        
        guard let output = viewModel?.transform(input: input) else { return }
        
        
        output.successSearchPokemon.drive(onNext: { viewObject in
            self.shownData = viewObject
            self.loading = false
            self.refreshControl.endRefreshing()
            self.collectionView.reloadData()
        }).disposed(by: bag)
        
        output.successLoadMore.drive(onNext: { viewObject in
            self.data += viewObject
            self.shownData = self.data
            self.loading = false
            self.refreshControl.endRefreshing()
            self.collectionView.reloadData()
        }).disposed(by: bag)
        
        output.successFetchPokemonList.drive(onNext: { viewObject in
            self.data = viewObject
            self.shownData = self.data
            self.loading = false
            self.refreshControl.endRefreshing()
            self.collectionView.reloadData()
        }).disposed(by: bag)
        
        output.loading.drive(onNext: { isLoading in
            self.showLoading(isLoading: isLoading)
            if !isLoading{
                self.refreshControl.endRefreshing()
            }
        }).disposed(by: bag)
        
        output.error.drive(onNext: { error in
            guard let error = error as? BaseError else { return }
            self.showToast(message: error.getError.getDesc())
            self.loading = false
            self.refreshControl.endRefreshing()
            self.collectionView.reloadData()
        }).disposed(by: bag)
    }
    
    private func configureSearch(){
        searchBar
            .rx.cancelButtonClicked
            .subscribe(onNext: { _ in
                self.shownData = self.data
                self.collectionView.reloadData()
            }).disposed(by: bag)
    }
    
    @objc func refresh(_ sender: AnyObject) {
        fetchList.onNext()
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout,
                              UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return shownData.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String.className(HomeCollectionViewCell.self),
            for: indexPath
        ) as? HomeCollectionViewCell {
            cell.configureCell(data: shownData[indexPath.row])
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
        referenceSizeForFooterInSection section: Int
    ) -> CGSize
    {
        return loading ?
        CGSize(width: collectionView.bounds.size.width, height: 55) : CGSize.zero
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath) -> UICollectionReusableView
    {
        if kind == UICollectionView.elementKindSectionFooter {
            let aFooterView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: "IndicatorCell",
                for: indexPath) as! IndicatorCell
            loadingView = aFooterView
            loadingView?.backgroundColor = UIColor.clear
            loading ? loadingView?.indicator.startAnimating() :
            loadingView?.indicator.stopAnimating()
            return aFooterView
        }
        return UICollectionReusableView()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let sizeHeight = scrollView.contentSize.height
        let frameHeight = scrollView.frame.height
        if offsetY - 100 > (sizeHeight - frameHeight) {
            if !loading {
                self.collectionView.reloadData()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.loadMore.onNext()
                }
                loading = true
            }
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        let vc = DetailViewController()
        let detail = shownData[indexPath.row]
        let detailVO = DetailViewObject(
            id: detail.id,
            name: detail.name,
            flavorText: detail.flavorText
        )
        vc.viewModel = DetailViewModel(detailVO: detailVO)
        navigationController?.pushViewController(vc, animated: false)
    }
}

