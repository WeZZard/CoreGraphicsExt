//
//  CGRect+VisualBasedInitialize-UIKit.swift
//  CoreGraphicsExt
//
//  Created by WeZZard on 11/19/15.
//
//

import CoreGraphics

extension CGRect {
    /// Create a CGRect value with given vertices parameters
    @_transparent
    public init(top: CGFloat, right: CGFloat, bottom: CGFloat, left: CGFloat) {
        let origin = CGPoint(x: left, y: top)
        let size = CGSize(width: right - left, height: bottom - top)
        self.init(origin: origin, size: size)
    }
}
