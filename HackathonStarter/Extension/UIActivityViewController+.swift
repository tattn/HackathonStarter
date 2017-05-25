//
//  UIActivityViewController+.swift
//  HackathonStarter
//
//  Created by 田中　達也 on 2016/08/13.
//  Copyright © 2016年 tattn. All rights reserved.
//

import UIKit

extension UIActivityViewController {

    func setExcludedActivity(types: [UIActivityType]) -> Self {
        excludedActivityTypes = types
        return self
    }

    func show(animated: Bool = true) {
        UIApplication.shared.topViewController?.present(self, animated: animated, completion: nil)
    }
}
