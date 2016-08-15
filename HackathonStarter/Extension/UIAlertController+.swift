//
//  UIAlertController+.swift
//  HackathonStarter
//
//  Created by 田中　達也 on 2016/08/12.
//  Copyright © 2016年 tattn. All rights reserved.
//

import UIKit

extension UIAlertController {

    func addAction(title title: String, style: UIAlertActionStyle = .Default, handler: (UIAlertAction -> Void)? = nil) -> Self {
        let okAction = UIAlertAction(title: title, style: style, handler: handler)
        addAction(okAction)
        return self
    }

    func addActionWithTextFields(title title: String, style: UIAlertActionStyle = .Default, handler: ((UIAlertAction, [UITextField]) -> Void)? = nil) -> Self {
        let okAction = UIAlertAction(title: title, style: style) { [weak self] action in
            handler?(action, self?.textFields ?? [])
        }
        addAction(okAction)
        return self
    }

    func configureForIPad(sourceRect: CGRect, sourceView: UIView? = nil) -> Self {
        popoverPresentationController?.sourceRect = sourceRect
        if let sourceView = UIApplication.sharedApplication().topViewController?.view {
            popoverPresentationController?.sourceView = sourceView
        }
        return self
    }

    func configureForIPad(barButtonItem: UIBarButtonItem) -> Self {
        popoverPresentationController?.barButtonItem = barButtonItem
        return self
    }

    func addTextField(handler: UITextField -> Void) -> Self {
        addTextFieldWithConfigurationHandler(handler)
        return self
    }

    func show() {
        UIApplication.sharedApplication().topViewController?.presentViewController(self, animated: true, completion: nil)
    }
}
