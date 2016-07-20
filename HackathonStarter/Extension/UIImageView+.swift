//
//  UIImageView+.swift
//  HackathonStarter
//
//  Created by 田中　達也 on 2016/07/20.
//  Copyright © 2016年 tattn. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {

    func setWebImage(url: NSURL?) {
        if let url = url {
            kf_setImageWithURL(url)
        }
    }

    @nonobjc
    func setWebImage(urlString: String) {
        setWebImage(urlString.url)
    }

    func cancelDownload() {
        kf_cancelDownloadTask()
    }
}
