//
//  SwipeReturnable.swift
//  HackathonStarter
//
//  Created by 田中　達也 on 2016/07/21.
//  Copyright © 2016年 tattn. All rights reserved.
//

import UIKit

protocol SwipeReturnable: class {
    func addSwipeReturnGesture()
}

extension SwipeReturnable where Self: UIViewController {
    func addSwipeReturnGesture() {
        let gestureToRight = UISwipeGestureRecognizer(target: self, action: #selector(swipeBack))
        gestureToRight.direction = UISwipeGestureRecognizerDirection.right
        view.addGestureRecognizer(gestureToRight)
    }
}

extension UIViewController: SwipeReturnable {}

extension UIViewController {
    func swipeBack() {
        navigationController?.popViewController(animated: true)
    }
}
