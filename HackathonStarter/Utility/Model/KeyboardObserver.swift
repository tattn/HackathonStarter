//
//  KeyboardObserver.swift
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

public final class KeyboardObserver {

    public private(set) var isShown = false

    public weak var delegate: KeyboardDelegate?

    public init() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @objc private func keyboardWillShow(_ notification: Notification) {
        isShown = true

        guard let userInfo = notification.userInfo,
            let keyboardRect = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }

        delegate?.keyboardWillShow(rect: keyboardRect)
    }

    @objc private func keyboardWillHide(_ notification: Notification) {
        isShown = false

        guard let userInfo = notification.userInfo,
            let keyboardRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue else { return }

        delegate?.keyboardWillHide(rect: keyboardRect)
    }
}
