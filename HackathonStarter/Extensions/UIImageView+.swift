//
//  UIImageView+.swift
//  HackathonStarter
//
//  Created by Tatsuya Tanaka on 2019/07/24.
//  Copyright © 2019 Tatsuya Tanaka. All rights reserved.
//

import UIKit
import Nuke

public extension UIImageView {
    func setImage(with url: URL, placeholder: UIImage? = nil) {
        let options = ImageLoadingOptions(
            placeholder: placeholder,
            transition: .fadeIn(duration: 0.1)
        )
        Nuke.loadImage(with: url, options: options, into: self)
    }
}
