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

    func setWebImage(url: NSURL?) {
        if let url = url {
            kf_setImageWithURL(url)
        }
    }

    @nonobjc
    func setWebImage(urlString: String) {
        setWebImage(urlString.url)
    }

    func setWebImageWithIndicator(url: NSURL?) {
        if let url = url {
            addLoading()
            kf_setImageWithURL(url, placeholderImage: nil, optionsInfo: nil, progressBlock: nil) { [weak self] image, error, cacheType, imageURL in
                self?.removeLoading()
            }
        }
    }

    @nonobjc
    func setWebImageWithIndicator(urlString: String) {
        setWebImageWithIndicator(urlString.url)
    }

    func cancelDownload() {
        kf_cancelDownloadTask()
    }

    private func addLoading() {
        if let loading = viewWithTag(activityIndicatorViewTag) as? UIActivityIndicatorView {
            loading.startAnimating()
        } else {
            let activityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            activityIndicatorView.center = center
            activityIndicatorView.hidesWhenStopped = false
            activityIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.White
            activityIndicatorView.layer.opacity = 0.8
            activityIndicatorView.color = UIColor.whiteColor()

            activityIndicatorView.tag = activityIndicatorViewTag
            activityIndicatorView.startAnimating()
            addSubview(activityIndicatorView)

            let views = ["activityIndicatorView":activityIndicatorView]
            activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
            addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[activityIndicatorView]|", options: [], metrics: nil, views: views))
            addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[activityIndicatorView]|", options: [], metrics: nil, views: views))
        }
    }

    private func removeLoading() {
        if let activityIndicatorView = self.viewWithTag(activityIndicatorViewTag) as? UIActivityIndicatorView {
            activityIndicatorView.stopAnimating()
            activityIndicatorView.removeFromSuperview()
        }
    }
}
