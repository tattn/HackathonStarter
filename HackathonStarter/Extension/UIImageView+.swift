//
//  UIImageView+.swift
//  HackathonStarter
//
//  Created by 田中　達也 on 2016/07/20.
//  Copyright © 2016年 tattn. All rights reserved.
//

import UIKit
import Kingfisher

private let activityIndicatorViewTag = 2017

extension UIImageView {

    func setWebImage(_ url: URL?) {
        kf.setImage(with: url)
    }

    @nonobjc
    func setWebImage(_ urlString: String) {
        setWebImage(urlString.url)
    }

    func setWebImageWithIndicator(_ url: URL?, indicatorColor: UIColor = .white) {
        addLoading()
        kf.setImage(with: url, placeholder: nil, options: nil, progressBlock: nil) { [weak self] _ in
            self?.removeLoading()
        }
    }

    @nonobjc
    func setWebImageWithIndicator(_ urlString: String) {
        setWebImageWithIndicator(urlString.url)
    }

    func cancelDownload() {
        kf.cancelDownloadTask()
    }

    fileprivate func addLoading(_ indicatorColor: UIColor = .white) {
        if let loading = viewWithTag(activityIndicatorViewTag) as? UIActivityIndicatorView {
            loading.startAnimating()
        } else {
            let activityIndicatorView = UIActivityIndicatorView(frame: .init(x: 0, y: 0, width: 50, height: 50))
            activityIndicatorView.center = center
            activityIndicatorView.hidesWhenStopped = false
            activityIndicatorView.activityIndicatorViewStyle = .white
            activityIndicatorView.layer.opacity = 0.8
            activityIndicatorView.color = indicatorColor

            activityIndicatorView.tag = activityIndicatorViewTag
            activityIndicatorView.startAnimating()
            addSubview(activityIndicatorView)
            activityIndicatorView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        }
    }

    fileprivate func removeLoading() {
        if let activityIndicatorView = self.viewWithTag(activityIndicatorViewTag) as? UIActivityIndicatorView {
            activityIndicatorView.stopAnimating()
            activityIndicatorView.removeFromSuperview()
        }
    }
}
