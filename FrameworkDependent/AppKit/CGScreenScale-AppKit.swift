//
//  ScreenPixelAlignment-AppKit.swift
//  CoreGraphicsExt
//
//  Created by WeZZard on 11/17/15.
//
//

import AppKit

@_transparent
internal var CGScreenScale: CGFloat? {
    return NSScreen.main?.backingScaleFactor
}
