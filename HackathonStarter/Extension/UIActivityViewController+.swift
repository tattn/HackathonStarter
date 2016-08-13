//
//  UIActivityViewController+.swift
//  HackathonStarter
//
//  Created by 田中　達也 on 2016/08/13.
//  Copyright © 2016年 tattn. All rights reserved.
//

import UIKit

extension UIActivityViewController {

    func setExcludedActivity(types types: [String]) -> Self {
        excludedActivityTypes = types
        return self
    }

    func show(animated animated: Bool = true) {
        UIApplication.sharedApplication().topViewController?.presentViewController(self, animated: animated, completion: nil)
    }
}
