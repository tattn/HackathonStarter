//
//  ProgressHUD.swift
//  HackathonStarter
//
//  Created by 田中　達也 on 2016/08/13.
//  Copyright © 2016年 tattn. All rights reserved.
//

import UIKit
import SVProgressHUD

class ProgressHUD: NSObject {
    static func show(title: String? = nil, ignoreInteraction: Bool = false) {
        if let title = title {
            SVProgressHUD.show(withStatus: title)
        } else {
            SVProgressHUD.show()
        }

        if ignoreInteraction {
            UIApplication.shared.beginIgnoringInteractionEvents()
        }
    }

    static func dismiss() {
        SVProgressHUD.dismiss()
        if UIApplication.shared.isIgnoringInteractionEvents {
            UIApplication.shared.endIgnoringInteractionEvents()
        }
    }
}

import RxSwift
import RxCocoa

extension Reactive where Base: ProgressHUD {

    static var isShowing: AnyObserver<Bool> {
        return AnyObserver { event in
            MainScheduler.ensureExecutingOnScheduler()
            
            switch (event) {
            case .next(let value):
                if value {
                    ProgressHUD.show()
                } else {
                    ProgressHUD.dismiss()
                }
            case .error:
                ProgressHUD.dismiss()
            case .completed:
                break
            }
        }
    }
}

import RxHelper

extension ObservableConvertibleType {
    func progress(with bag: DisposeBag) -> Observable<E> {
        let activityIndicator = ActivityIndicator()
        activityIndicator
            .asDriver()
            .drive(ProgressHUD.rx.isShowing)
            .disposed(by: bag)
        return trackActivity(activityIndicator)
    }
}
