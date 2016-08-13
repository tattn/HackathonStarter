//
//  ProgressHUD.swift
//  HackathonStarter
//
//  Created by 田中　達也 on 2016/08/13.
//  Copyright © 2016年 tattn. All rights reserved.
//

import UIKit
import SVProgressHUD

struct ProgressHUD {
    static func show(title title: String? = nil, ignoreInteraction: Bool = false) {
        if let title = title {
            SVProgressHUD.showWithStatus(title)
        } else {
            SVProgressHUD.show()
        }

        if ignoreInteraction {
            UIApplication.sharedApplication().beginIgnoringInteractionEvents()
        }
    }

    static func dismiss() {
        SVProgressHUD.dismiss()
        if UIApplication.sharedApplication().isIgnoringInteractionEvents() {
            UIApplication.sharedApplication().endIgnoringInteractionEvents()
        }
    }
}
