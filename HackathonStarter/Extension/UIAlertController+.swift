//
//  UIAlertController+.swift
//  HackathonStarter
//
//  Created by 田中　達也 on 2016/08/12.
//  Copyright © 2016年 tattn. All rights reserved.
//

import UIKit

extension UIAlertController {

    func addAction(title: String, style: UIAlertActionStyle = .default, handler: ((UIAlertAction) -> Void)? = nil) -> Self {
        let okAction = UIAlertAction(title: title, style: style, handler: handler)
        addAction(okAction)
        return self
    }

    func addActionWithTextFields(title: String, style: UIAlertActionStyle = .default, handler: ((UIAlertAction, [UITextField]) -> Void)? = nil) -> Self {
        let okAction = UIAlertAction(title: title, style: style) { [weak self] action in
            handler?(action, self?.textFields ?? [])
        }
        addAction(okAction)
        return self
    }

    func configureForIPad(_ sourceRect: CGRect, sourceView: UIView? = nil) -> Self {
        popoverPresentationController?.sourceRect = sourceRect
        if let sourceView = UIApplication.shared.topViewController?.view {
            popoverPresentationController?.sourceView = sourceView
        }
        return self
    }

    func configureForIPad(_ barButtonItem: UIBarButtonItem) -> Self {
        popoverPresentationController?.barButtonItem = barButtonItem
        return self
    }

    func addTextField(_ handler: @escaping (UITextField) -> Void) -> Self {
        self.addTextField(configurationHandler: handler)
        return self
    }

    func show() {
        UIApplication.shared.topViewController?.present(self, animated: true, completion: nil)
    }
}
