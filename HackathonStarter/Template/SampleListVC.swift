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

final class SampleListCell: UITableViewCell, Reusable, NibInstantiatable {
    @IBOutlet private weak var thumbnailImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    func inject(_ dependency: SampleItem) {
        thumbnailImageView.setWebImage(dependency.imageURL)
        titleLabel.text = dependency.title
    }
}

// MARK: - ViewController

final class SampleListVC: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.rowHeight = UITableViewAutomaticDimension
            tableView.estimatedRowHeight = 50
        }
    }
    
    fileprivate let requester = HTTPJSONRequest()
        .setURL("https://jsonplaceholder.typicode.com/photos")
    
    fileprivate lazy var items: Observable<[SampleItem]> = {
        return self.requester
            .asObservable()
            .map { try [SampleItem].decode($0) }
    }()
    
    static var instantiateSource: InstantiateSource {
        return .identifier(className)
    }
    
    fileprivate let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerNib(type: SampleListCell.self)
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.indexPathsForSelectedRows?
            .forEach { tableView.deselectRow(at: $0, animated: true) }
    }
    
    private func bind() {
        items.bind(to: tableView.rx.items) { tableView, row, element in
            return SampleListCell.dequeue(from: tableView,
                                          for: IndexPath(row: row, section: 0),
                                          with: element)
        }
        .disposed(by: disposeBag)
    }
}

extension SampleListVC: StoryboardInstantiatable {
    struct Dependency {
        let title: String
//        let id: String
    }
    
    func inject(_ dependency: Dependency) {
        title = dependency.title
//        dependency.id
    }
}
