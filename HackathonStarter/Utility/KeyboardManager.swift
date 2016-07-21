//
//  KeyboardManager.swift
//  HackathonStarter
//
//  Created by 田中　達也 on 2016/07/02.
//  Copyright © 2016年 tattn. All rights reserved.
//

import UIKit

public protocol KeyboardDelegate: class {
    func keyboardWillShow(rect rect: CGRect)
    func keyboardWillHide(rect rect: CGRect)
}

/// キーボードを管理するクラス
public final class KeyboardManager: NSObject {

    public static let shared = KeyboardManager()

    public private(set) var isShown = false

    public weak var delegate: KeyboardDelegate?

    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    public func setup() {
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }

    @objc private func keyboardWillShow(notification: NSNotification) {
        isShown = true

        guard let userInfo = notification.userInfo else { return }
        guard let keyboardRect = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.CGRectValue() else { return }

        delegate?.keyboardWillShow(rect: keyboardRect)
    }

    @objc private func keyboardWillHide(notification: NSNotification) {
        isShown = false

        guard let userInfo = notification.userInfo else { return }
        guard let keyboardRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() else { return }

        delegate?.keyboardWillHide(rect: keyboardRect)
    }
}
