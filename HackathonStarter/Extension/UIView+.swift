//
//  UIView+.swift
//  HackathonStarter
//
//  Created by 田中　達也 on 2016/06/30.
//  Copyright © 2016年 tattn. All rights reserved.
//

import UIKit

extension UIView {
    func removeAllSubviews() {
        for subview in self.subviews {
            subview.removeFromSuperview()
        }
    }

    func image(size: CGSize) -> UIImage? {
        let resizeSize = CGSize(
            width: size.width,
            height: bounds.size.height * (size.width / bounds.size.width)
        )

        let scaleBounds = CGRect(x: 0, y: 0, width: resizeSize.width, height: resizeSize.height)

        UIGraphicsBeginImageContextWithOptions(scaleBounds.size, true, 0.0)

        drawViewHierarchyInRect(scaleBounds, afterScreenUpdates: false)

        var image: UIImage?
        let contextImage = UIGraphicsGetImageFromCurrentImageContext()

        if let cgImage = contextImage.CGImage {
            image = UIImage(
                CGImage: cgImage,
                scale: UIScreen.mainScreen().scale,
                orientation: contextImage.imageOrientation
            )
        }

        UIGraphicsEndImageContext()

        if let captureImage = image
            where !(captureImage.size.width == size.width && captureImage.size.height == size.height) {
            image = captureImage.cropping(CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height))
        }
        
        return image
    }

}
