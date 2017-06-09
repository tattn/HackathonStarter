//
//  TopVC.swift
//  HackathonStarter
//
//  Created by 田中　達也 on 2016/06/30.
//  Copyright © 2016年 tattn. All rights reserved.
//

import UIKit
import Instantiate
import InstantiateStandard
import RxSwift
import RxCocoa

final class TopVC: UIViewController, StoryboardInstantiatable {
    
    @IBOutlet private weak var label: UILabel!
    @IBOutlet private weak var label2: UILabel!
    
    static var storyboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
    
    func inject(_ dependency: String) {
        label.text = dependency
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "🐱"
        label2.text = "🐶"
        
        var tapGesture = UITapGestureRecognizer()
        label.addGestureRecognizer(tapGesture)
        tapGesture.rx.event.subscribe(onNext: { _ in
            self.navigationController?.pushViewController(SimpleListVC.instantiate(with: .init(title: "🐱")), animated: true)
        })
        .disposed(by: disposeBag)
        
        tapGesture = UITapGestureRecognizer()
        label2.addGestureRecognizer(tapGesture)
        tapGesture.rx.event.subscribe(onNext: { _ in
            self.navigationController?.pushViewController(SimpleCollectionVC.instantiate(with: .init(title: "🐶")), animated: true)
        })
        .disposed(by: disposeBag)
    }

}
