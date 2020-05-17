//
//  UIView.swift
//  PokeDex
//
//  Created by Santiago Bustamante on 16/05/20.
//  Copyright © 2020 Santiago Bustamante. All rights reserved.
//

import UIKit

extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        var cornArr = CACornerMask()

        if corners.contains(.topRight) {
            cornArr.insert(.layerMaxXMinYCorner)
        }

        if corners.contains(.topLeft) {
            cornArr.insert(.layerMinXMinYCorner)
        }

        if corners.contains(.bottomLeft) {
            cornArr.insert(.layerMinXMaxYCorner)
        }

        if corners.contains(.bottomRight) {
            cornArr.insert(.layerMaxXMaxYCorner)
        }

        clipsToBounds = true
        layer.cornerRadius = radius
        layer.maskedCorners = cornArr
    }
}
