//
//  KeyboardManager.swift
//  HackathonStarter
//
//  Created by 田中　達也 on 2016/07/02.
//  Copyright © 2016年 tattn. All rights reserved.
//

import UIKit

public protocol KeyboardDelegate: class {
    func keyboardWillShow(rect: CGRect)
    func keyboardWillHide(rect: CGRect)
}

/// キーボードを管理するクラス
public final class KeyboardManager: NSObject {

    public static let shared = KeyboardManager()

    public fileprivate(set) var isShown = false

    public weak var delegate: KeyboardDelegate?

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    public func setup() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }

    @objc fileprivate func keyboardWillShow(_ notification: Notification) {
        isShown = true

        guard let userInfo = notification.userInfo else { return }
        guard let keyboardRect = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }

        delegate?.keyboardWillShow(rect: keyboardRect)
    }

    @objc fileprivate func keyboardWillHide(_ notification: Notification) {
        isShown = false

        guard let userInfo = notification.userInfo else { return }
        guard let keyboardRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue else { return }

        delegate?.keyboardWillHide(rect: keyboardRect)
    }
}
