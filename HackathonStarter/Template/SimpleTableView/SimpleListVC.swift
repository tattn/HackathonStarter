//
//  SampleListVC.swift
//  HackathonStarter
//
//  Created by Tatsuya Tanaka on 20170529.
//  Copyright © 2017年 tattn. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxHelper

// MARK: - Model

struct SampleItem: Codable {
    let title: String
    let thumbnailUrl: URL
}

// MARK: - Cell

final class SimpleListCell: UITableViewCell, NibInstantiatable {
    @IBOutlet private weak var thumbnailImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    func inject(_ dependency: SampleItem) {
        thumbnailImageView.setImage(with: dependency.thumbnailUrl)
        titleLabel.text = dependency.title
    }
}

// MARK: - ViewController

final class SimpleListVC: UIViewController, StoryboardInstantiatable {
    
    @IBOutlet private weak var tableView: UITableView!
    
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
        tableView.refreshControl = UIRefreshControl()
        tableView.register(cellType: SimpleListCell.self)
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.indexPathsForSelectedRows?
            .forEach { tableView.deselectRow(at: $0, animated: true) }
        requestSubject.onNext(())
    }
    
    private func bind() {
        items
            .do(onNext: { [unowned self] _ in self.tableView.refreshControl?.endRefreshing() })
            .drive(tableView.rx.items) { tableView, row, element in
                tableView.dequeueReusableCell(with: SimpleListCell.self, for: IndexPath(row: row, section: 0)).apply {
                    $0.inject(element)
                }
            }
            .disposed(by: disposeBag)
        
        tableView.refreshControl?.rx
            .controlEvent(.valueChanged)
            .filter { [unowned self] _ in self.tableView.refreshControl?.isRefreshing == true }
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
