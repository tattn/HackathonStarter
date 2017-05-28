//
//  IBDesignable.swift
//  HackathonStarter
//
//  Created by 田中　達也 on 2016/07/01.
//  Copyright © 2016年 tattn. All rights reserved.
//

import UIKit

protocol IBRoundable: class {
    var cornerRadius: CGFloat { get set }
    var masksToBounds: Bool { get set }
}

protocol IBBorderable: class {
    var borderColor: UIColor { get set }
    var borderWidth: CGFloat { get set }
}

@IBDesignable
class IBDesignableView: UIView, IBRoundable, IBBorderable {

    @IBInspectable var borderColor: UIColor = .black {
        didSet { layer.borderColor = borderColor.cgColor }
    }
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet { layer.borderWidth = borderWidth }
    }
    @IBInspectable var cornerRadius: CGFloat = 5.0 {
        didSet { layer.cornerRadius = cornerRadius }
    }
    @IBInspectable var masksToBounds: Bool = true {
        didSet { layer.masksToBounds = masksToBounds }
    }
}

@IBDesignable
class IBDesignableLabel: UILabel, IBRoundable, IBBorderable {

    @IBInspectable var borderColor: UIColor = .black {
        didSet { layer.borderColor = borderColor.cgColor }
    }
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet { layer.borderWidth = borderWidth }
    }
    @IBInspectable var cornerRadius: CGFloat = 5.0 {
        didSet { layer.cornerRadius = cornerRadius }
    }
    @IBInspectable var masksToBounds: Bool = true {
        didSet { layer.masksToBounds = masksToBounds }
    }
}

@IBDesignable
class IBDesignableButton: UIButton, IBRoundable, IBBorderable {

    @IBInspectable var borderColor: UIColor = .black {
        didSet { layer.borderColor = borderColor.cgColor }
    }
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet { layer.borderWidth = borderWidth }
    }
    @IBInspectable var cornerRadius: CGFloat = 5.0 {
        didSet { layer.cornerRadius = cornerRadius }
    }
    @IBInspectable var masksToBounds: Bool = true {
        didSet { layer.masksToBounds = masksToBounds }
    }
}

@IBDesignable
class IBDesignableImageView: UIImageView, IBRoundable, IBBorderable {

    @IBInspectable var borderColor: UIColor = .black {
        didSet { layer.borderColor = borderColor.cgColor }
    }
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet { layer.borderWidth = borderWidth }
    }
    @IBInspectable var cornerRadius: CGFloat = 5.0 {
        didSet { layer.cornerRadius = cornerRadius }
    }
    @IBInspectable var masksToBounds: Bool = true {
        didSet { layer.masksToBounds = masksToBounds }
    }
}

@IBDesignable
class IBDesignableCollectionViewCell: UICollectionViewCell, IBRoundable, IBBorderable {

    @IBInspectable var borderColor: UIColor = .black {
        didSet { layer.borderColor = borderColor.cgColor }
    }
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet { layer.borderWidth = borderWidth }
    }
    @IBInspectable var cornerRadius: CGFloat = 5.0 {
        didSet { layer.cornerRadius = cornerRadius }
    }
    @IBInspectable var masksToBounds: Bool = true {
        didSet { layer.masksToBounds = masksToBounds }
    }
}

@IBDesignable
class IBDesignableTableViewCell: UITableViewCell, IBRoundable, IBBorderable {

    @IBInspectable var borderColor: UIColor = .black {
        didSet { layer.borderColor = borderColor.cgColor }
    }
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet { layer.borderWidth = borderWidth }
    }
    @IBInspectable var cornerRadius: CGFloat = 5.0 {
        didSet { layer.cornerRadius = cornerRadius }
    }
    @IBInspectable var masksToBounds: Bool = true {
        didSet { layer.masksToBounds = masksToBounds }
    }
}
