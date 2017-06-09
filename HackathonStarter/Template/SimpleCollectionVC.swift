//
//  SimpleCollectionVC.swift
//  HackathonStarter
//
//  Created by Tatsuya Tanaka on 20170610.
//  Copyright © 2017年 tattn. All rights reserved.
//

import Foundation
import UIKit
import Instantiate
import InstantiateStandard
import RxSwift
import RxCocoa
import Himotoki
import RxHelper

// MARK: - Cell

final class SimpleCollectionViewCell: UICollectionViewCell, Reusable, NibInstantiatable {
    @IBOutlet private weak var thumbnailImageView: UIImageView!
    
    func inject(_ dependency: SampleItem) {
        thumbnailImageView.setWebImage(dependency.imageURL)
    }
}

// MARK: - ViewController

final class SimpleCollectionVC: UIViewController {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private let requestSubject = PublishSubject<Void>()
    private lazy var items: Driver<[SampleItem]> = {
        return self.requestSubject
            .flatMapLatest { [unowned self] _ in self.requestListData() }
            .asDriver(onErrorDriveWith: .empty())
    }()
    
    static var instantiateSource: InstantiateSource {
        return .identifier(className)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.refreshControl = UIRefreshControl()
        collectionView.registerNib(type: SimpleCollectionViewCell.self)
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        requestSubject.onNext()
    }
    
    private func bind() {
        items
            .do(onNext: { [unowned self] _ in self.collectionView.refreshControl?.endRefreshing() })
            .drive(collectionView.rx.items) { collectionView, index, item in
                SimpleCollectionViewCell.dequeue(from: collectionView,
                                                 for: IndexPath(row: index, section: 0),
                                                 with: item)
            }
            .disposed(by: disposeBag)
        
        collectionView.refreshControl?.rx
            .controlEvent(.valueChanged)
            .filter { [unowned self] _ in self.collectionView.refreshControl?.isRefreshing == true }
            .bind(to: requestSubject)
            .disposed(by: disposeBag)
    }
    
    private func requestListData() -> Observable<[SampleItem]> {
        return HTTPJSONRequest()
            .setURL("https://jsonplaceholder.typicode.com/photos")
            .asObservable()
            .progress(with: disposeBag)
            .map { try [SampleItem].decode($0) }
    }

}

extension SimpleCollectionVC: StoryboardInstantiatable {
    struct Dependency {
        let title: String
//        let id: String
    }
    
    func inject(_ dependency: Dependency) {
        title = dependency.title
//        dependency.id
    }
}
