//
//  SampleListVC.swift
//  HackathonStarter
//
//  Created by Tatsuya Tanaka on 20170529.
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

// MARK: - Model

struct SampleItem: Decodable {
    let title: String
    let imageURL: String
    
    static func decode(_ e: Extractor) throws -> SampleItem {
        return try SampleItem(
            title: e <| "title",
            imageURL: e <| "thumbnailUrl"
        )
    }
}

// MARK: - Cell

final class SimpleListCell: UITableViewCell, Reusable, NibInstantiatable {
    @IBOutlet private weak var thumbnailImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    func inject(_ dependency: SampleItem) {
        thumbnailImageView.setWebImage(dependency.imageURL)
        titleLabel.text = dependency.title
    }
}

// MARK: - ViewController

final class SimpleListVC: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.rowHeight = UITableViewAutomaticDimension
            tableView.estimatedRowHeight = 50
        }
    }
    
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
        tableView.refreshControl = UIRefreshControl()
        tableView.registerNib(type: SimpleListCell.self)
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.indexPathsForSelectedRows?
            .forEach { tableView.deselectRow(at: $0, animated: true) }
        requestSubject.onNext()
    }
    
    private func bind() {
        items
            .do(onNext: { [unowned self] _ in self.tableView.refreshControl?.endRefreshing() })
            .drive(tableView.rx.items) { tableView, row, element in
                SimpleListCell.dequeue(from: tableView,
                                          for: IndexPath(row: row, section: 0),
                                          with: element)
            }
            .disposed(by: disposeBag)
        
        tableView.refreshControl?.rx
            .controlEvent(.valueChanged)
            .filter { [unowned self] _ in self.tableView.refreshControl?.isRefreshing == true }
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

extension SimpleListVC: StoryboardInstantiatable {
    struct Dependency {
        let title: String
//        let id: String
    }
    
    func inject(_ dependency: Dependency) {
        title = dependency.title
//        dependency.id
    }
}
