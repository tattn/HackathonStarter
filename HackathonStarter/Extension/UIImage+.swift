//
//  UIImage+.swift
//  HackathonStarter
//
//  Created by 田中　達也 on 2016/06/30.
//  Copyright © 2016年 tattn. All rights reserved.
//

import UIKit

extension UIImage {
    convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        UIGraphicsBeginImageContextWithOptions(size, true, 0)
        color.setFill()
        UIRectFill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        guard let cgImage = image.CGImage else { return nil }
        self.init(CGImage: cgImage)
    }

    convenience init?(named: String, tintColor: UIColor) {
        let image = UIImage(named: named)?.imageWithTint(color: tintColor)
        guard let cgImage = image?.CGImage else { return nil }
        self.init(CGImage: cgImage)
    }

    func imageWithTint(color tintColor: UIColor) -> UIImage {

        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)

        UIGraphicsBeginImageContextWithOptions(rect.size, false, scale)

        drawInRect(rect)

        let ctx = UIGraphicsGetCurrentContext()
        CGContextSetBlendMode(ctx, CGBlendMode.SourceIn)

        CGContextSetFillColorWithColor(ctx, tintColor.CGColor)
        CGContextFillRect(ctx, rect)

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return image
    }

    func cropping(rect: CGRect) -> UIImage? {
        let originalRect = CGRect(
            x: rect.origin.x * scale,
            y: rect.origin.y * scale,
            width: rect.size.width * scale,
            height: rect.size.height * scale
        )

        var croppingImage: UIImage?

        if let cgImage = CGImage,
            imageRef = CGImageCreateWithImageInRect(cgImage, originalRect) {
            croppingImage = UIImage(CGImage: imageRef, scale: scale, orientation: imageOrientation)
        }
        
        return croppingImage
    }

    func resize(size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContext(CGSize(
            width: size.width * scale,
            height: size.height * scale
        ))

        drawInRect(CGRect(x: 0, y: 0, width: size.width, height: size.height))

        let image = UIGraphicsGetImageFromCurrentImageContext()

        var resizedImage: UIImage?

        if let cgImage = image.CGImage {
            resizedImage = UIImage(CGImage: cgImage, scale:  scale, orientation: imageOrientation)
        }

        UIGraphicsEndImageContext()

        return resizedImage
    }

}
