//
//  UIFont+.swift
//  HackathonStarter
//
//  Created by 田中　達也 on 2016/07/27.
//  Copyright © 2016年 tattn. All rights reserved.
//

import UIKit

extension UIFont {

    func size(of string: String, constrainedToWidth width: Double) -> CGSize {
        return (string as NSString)
               .boundingRect(with: CGSize(width: width, height: Double.greatestFiniteMagnitude),
                                     options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                     attributes: [NSFontAttributeName: self],
                                     context: nil).size
    }

}
