//
//  ScreenPixelAlignment-WatchKit.swift
//  CoreGraphicsExt
//
//  Created by WeZZard on 11/17/15.
//
//

import WatchKit

internal var CGScreenScale: CGFloat? {
    return WKInterfaceDevice.current().screenScale
}
