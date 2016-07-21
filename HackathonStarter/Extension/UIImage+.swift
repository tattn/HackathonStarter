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

    func resizeAspectFitWith256x256() -> UIImage {
        return resizeAspectFitWithSize(CGSize(width: 256, height: 256))
    }

    func resizeAspectFitWithSize(size: CGSize) -> UIImage {
        let widthRatio  = size.width  / self.size.width
        let heightRatio = size.height / self.size.height
        let ratio = (widthRatio < heightRatio) ? widthRatio : heightRatio

        let resizedSize = CGSize(width: self.size.width*ratio, height: self.size.height*ratio)

        UIGraphicsBeginImageContextWithOptions(resizedSize, false, 0.0)
        drawInRect(CGRect(x: 0, y: 0, width: resizedSize.width, height: resizedSize.height))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return resizedImage
    }

    func toJPEG(quarity: CGFloat = 1.0) -> NSData? {
        return UIImageJPEGRepresentation(self, quarity)
    }

    func rounded() -> UIImage? {
        let imageView = UIImageView(image: self)
        imageView.layer.cornerRadius = min(size.height/2, size.width/2)
        imageView.layer.masksToBounds = true
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, 0.0)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.renderInContext(context)
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result
    }

    func circle() -> UIImage? {
        let square = CGSize(width: min(size.width, size.height), height: min(size.width, size.height))
        let imageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: square))
        imageView.contentMode = .ScaleAspectFill
        imageView.image = self
        imageView.layer.cornerRadius = square.width/2
        imageView.layer.masksToBounds = true
        UIGraphicsBeginImageContext(imageView.bounds.size)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.renderInContext(context)
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result
    }


}
