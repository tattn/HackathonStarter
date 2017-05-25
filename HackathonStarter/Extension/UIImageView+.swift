//
//  UIImageView+.swift
//  HackathonStarter
//
//  Created by 田中　達也 on 2016/07/20.
//  Copyright © 2016年 tattn. All rights reserved.
//

import UIKit
import Kingfisher

private let activityIndicatorViewTag = 2016

extension UIImageView {

    func setWebImage(_ url: URL?) {
        if let url = url {
            kf.setImage(with: url)
        }
    }

    @nonobjc
    func setWebImage(_ urlString: String) {
        setWebImage(urlString.url)
    }

    func setWebImageWithIndicator(_ url: URL?) {
        if let url = url {
            addLoading()
            kf.setImage(with: url, placeholder: nil, options: nil, progressBlock: nil) { [weak self] image, error, cacheType, imageURL in
                self?.removeLoading()
            }
        }
    }

    @nonobjc
    func setWebImageWithIndicator(_ urlString: String) {
        setWebImageWithIndicator(urlString.url)
    }

    func cancelDownload() {
        kf.cancelDownloadTask()
    }

    fileprivate func addLoading() {
        if let loading = viewWithTag(activityIndicatorViewTag) as? UIActivityIndicatorView {
            loading.startAnimating()
        } else {
            let activityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            activityIndicatorView.center = center
            activityIndicatorView.hidesWhenStopped = false
            activityIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.white
            activityIndicatorView.layer.opacity = 0.8
            activityIndicatorView.color = UIColor.white

            activityIndicatorView.tag = activityIndicatorViewTag
            activityIndicatorView.startAnimating()
            addSubview(activityIndicatorView)

            let views = ["activityIndicatorView":activityIndicatorView]
            activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[activityIndicatorView]|", options: [], metrics: nil, views: views))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[activityIndicatorView]|", options: [], metrics: nil, views: views))
        }
    }

    fileprivate func removeLoading() {
        if let activityIndicatorView = self.viewWithTag(activityIndicatorViewTag) as? UIActivityIndicatorView {
            activityIndicatorView.stopAnimating()
            activityIndicatorView.removeFromSuperview()
        }
    }
}
