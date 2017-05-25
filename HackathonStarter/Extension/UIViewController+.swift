//
//  UIViewController+.swift
//  HackathonStarter
//
//  Created by 田中　達也 on 2016/07/22.
//  Copyright © 2016年 tattn. All rights reserved.
//

import UIKit

extension UIViewController {

    func setBackBarTitle(_ title: String = "") {
        let backButtonItem = UIBarButtonItem(title: title, style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButtonItem
    }
}
