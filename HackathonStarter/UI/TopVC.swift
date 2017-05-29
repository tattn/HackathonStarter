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
    
    static var storyboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
    
    private let disposeBag = DisposeBag()
    
    func inject(_ dependency: String) {
        label.text = dependency
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "🐱"
        
        let tapGesture = UITapGestureRecognizer()
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(tapGesture)
        tapGesture.rx.event.subscribe(onNext: { _ in
            self.present(SampleListVC.instantiate(with: .init(title: "List")), animated: true)
        })
        .disposed(by: disposeBag)
        
    }

}
