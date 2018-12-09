//
//  UIApplication+.swift
//  HackathonStarter
//
//  Created by 田中　達也 on 2016/06/30.
//  Copyright © 2016年 tattn. All rights reserved.
//

import UIKit

extension UIApplication {    
    func openSettingApplication() {
        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
    }
}
