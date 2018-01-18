//
//  SimpleCollectionVC.swift
//  HackathonStarter
//
//  Created by Tatsuya Tanaka on 20170610.
//  Copyright © 2017年 tattn. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxHelper

// MARK: - Cell

final class SimpleCollectionViewCell: UICollectionViewCell, NibInstantiatable {
    @IBOutlet private weak var thumbnailImageView: UIImageView!
    
    func inject(_ dependency: SampleItem) {
        thumbnailImageView.setWebImage(dependency.thumbnailUrl)
    }
}

// MARK: - ViewController

final class SimpleCollectionVC: UIViewController, StoryboardInstantiatable {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private let requestSubject = PublishSubject<Void>()
    private lazy var items: Driver<[SampleItem]> = {
        return self.requestSubject
            .flatMapLatest { [unowned self] _ in self.requestListData() }
            .asDriver(onErrorDriveWith: .empty())
    }()

    static var instantiateType: SwiftExtensions.StoryboardInstantiateType {
        return .identifier(className)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.refreshControl = UIRefreshControl()
        collectionView.register(cellType: SimpleCollectionViewCell.self)
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        requestSubject.onNext(())
    }
    
    private func bind() {
        items
            .do(onNext: { [unowned self] _ in self.collectionView.refreshControl?.endRefreshing() })
            .drive(collectionView.rx.items) { collectionView, index, item in
                collectionView.dequeueReusableCell(with: SimpleCollectionViewCell.self, for: IndexPath(row: index, section: 0)).apply {
                    $0.inject(item)
                }
            }
            .disposed(by: disposeBag)
        
        collectionView.refreshControl?.rx
            .controlEvent(.valueChanged)
            .filter { [unowned self] _ in self.collectionView.refreshControl?.isRefreshing == true }
            .bind(to: requestSubject)
            .disposed(by: disposeBag)
    }
    
    private func requestListData() -> Observable<[SampleItem]> {
        return HTTPDataRequest()
            .setURL("https://jsonplaceholder.typicode.com/photos")
            .asObservable()
            .progress(with: disposeBag)
            .map { try JSONDecoder().decode([SampleItem].self, from: $0) }
    }

}
