//
//  UIImageView+.swift
//  HackathonStarter
//
//  Created by 田中　達也 on 2016/07/20.
//  Copyright © 2016年 tattn. All rights reserved.
//

import UIKit
import Kingfisher

private let activityIndicatorViewTag = 2018

extension UIImageView {
    func setImage(with url: URL?, isIndicatorHidden: Bool = false, indicatorColor: UIColor = .white) {
        if !isIndicatorHidden { addLoading(color: indicatorColor) }
        kf.setImage(with: url, placeholder: nil, options: nil, progressBlock: nil) { [weak self] _ in
            if !isIndicatorHidden { self?.removeLoading() }
        }
    }

    func cancelDownload() {
        kf.cancelDownloadTask()
    }

    private func addLoading(color indicatorColor: UIColor = .white) {
        if let loading = viewWithTag(activityIndicatorViewTag) as? UIActivityIndicatorView {
            loading.startAnimating()
        } else {
            let activityIndicatorView = UIActivityIndicatorView(frame: .init(x: 0, y: 0, width: 50, height: 50))
            activityIndicatorView.center = center
            activityIndicatorView.hidesWhenStopped = false
            activityIndicatorView.style = .white
            activityIndicatorView.layer.opacity = 0.8
            activityIndicatorView.color = indicatorColor

            activityIndicatorView.tag = activityIndicatorViewTag
            activityIndicatorView.startAnimating()
            addSubview(activityIndicatorView)
            activityIndicatorView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        }
    }

    private func removeLoading() {
        if let activityIndicatorView = self.viewWithTag(activityIndicatorViewTag) as? UIActivityIndicatorView {
            activityIndicatorView.stopAnimating()
            activityIndicatorView.removeFromSuperview()
        }
    }
}
