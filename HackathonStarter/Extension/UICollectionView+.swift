//
//  UICollectionView+.swift
//  HackathonStarter
//
//  Created by 田中　達也 on 2016/06/30.
//  Copyright © 2016年 tattn. All rights reserved.
//

import UIKit

extension UICollectionView {
    func registerCell<T: UICollectionViewCell>(type type: T.Type) {
        let className = type.className
        let nib = UINib(nibName: className, bundle: nil)
        registerNib(nib, forCellWithReuseIdentifier: className)
    }

    func registerCells<T: UICollectionViewCell>(types types: [T.Type]) {
        types.forEach { registerCell(type: $0) }
    }

    func registerReusableView<T: UICollectionReusableView>(type type: T.Type, kind: String = UICollectionElementKindSectionHeader) {
        let className = type.className
        let nib = UINib(nibName: className, bundle: nil)
        registerNib(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: className)
    }

    func registerReusableViews<T: UICollectionReusableView>(types types: [T.Type], kind: String = UICollectionElementKindSectionHeader) {
        types.forEach { registerReusableView(type: $0, kind: kind) }
    }

    func dequeueCell<T: UICollectionViewCell>(type type: T.Type, indexPath: NSIndexPath) -> T {
        return dequeueReusableCellWithReuseIdentifier(type.className, forIndexPath: indexPath) as! T
    }

    func dequeueReusableView<T: UICollectionReusableView>(type type: T.Type, indexPath: NSIndexPath, kind: String = UICollectionElementKindSectionHeader) -> T {
        return dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: type.className, forIndexPath: indexPath) as! T
    }
}
