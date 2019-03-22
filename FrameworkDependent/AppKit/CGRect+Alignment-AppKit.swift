//
//  CGRect+Alignment-AppKit.swift
//  CoreGraphicsExt
//
//  Created by WeZZard on 11/16/15.
//
//

import CoreGraphics

extension CGRectVerticalAnchor {
    public func rectyByAligning(
        _ alignedRect: CGRect,
        and side: CGRectVerticalAnchor,
        on aligningRect: CGRect
        )
        -> CGRect
    {
        switch (self, side) {
        case (.top, .top):
            return CGRect(
                origin: CGPoint(x: alignedRect.minX, y: aligningRect.maxY),
                size: alignedRect.size
            )
        case (.top, .mid):
            return CGRect(
                origin: CGPoint(x: alignedRect.minX, y: aligningRect.midY),
                size: alignedRect.size
            )
        case (.top, .bottom):
            return CGRect(
                origin: CGPoint(x: alignedRect.minX, y: aligningRect.minY),
                size: alignedRect.size
            )
            
        case (.bottom, .bottom):
            let origin = CGPoint(x: alignedRect.minX,
                y: aligningRect.minY - alignedRect.size.height
            )
            return CGRect(origin: origin, size: alignedRect.size)
        case (.bottom, .mid):
            let origin = CGPoint(x: alignedRect.minX,
                y: aligningRect.midX - alignedRect.size.height
            )
            return CGRect(origin: origin, size: alignedRect.size)
        case (.bottom, .top):
            let origin = CGPoint(x: alignedRect.minX,
                y: aligningRect.maxY - alignedRect.size.height
            )
            return CGRect(origin: origin, size: alignedRect.size)
            
        case (.mid, .top):
            return CGRect(
                center: CGPoint(x: alignedRect.midX, y: aligningRect.maxY),
                size: alignedRect.size
            )
        case (.mid, .mid):
            return CGRect(
                center: CGPoint(x: alignedRect.midX, y: aligningRect.midY),
                size: alignedRect.size
            )
        case (.mid, .bottom):
            return CGRect(
                center: CGPoint(x: alignedRect.midX, y: aligningRect.minY),
                size: alignedRect.size
            )
        }
    }
}

extension CGRectHorizontalAnchor {
    public func rectyByAligning(
        _ alignedRect: CGRect,
        and side: CGRectHorizontalAnchor,
        on aligningRect: CGRect
        )
        -> CGRect
    {
        switch (self, side) {
        case (.left, .left):
            return CGRect(
                origin: CGPoint(x: aligningRect.minX, y: alignedRect.minY),
                size: alignedRect.size
            )
        case (.left, .mid):
            return CGRect(
                origin: CGPoint(x: aligningRect.midX, y: alignedRect.minY),
                size: alignedRect.size
            )
        case (.left, .right):
            return CGRect(
                origin: CGPoint(x: aligningRect.maxX, y: alignedRect.minY),
                size: alignedRect.size
            )
            
        case (.right, .right):
            let origin = CGPoint(
                x: aligningRect.maxX - alignedRect.size.width,
                y: alignedRect.minY
            )
            return CGRect(origin: origin, size: alignedRect.size)
        case (.right, .mid):
            let origin = CGPoint(
                x: aligningRect.midX - alignedRect.size.width,
                y: alignedRect.minY
            )
            return CGRect(origin: origin, size: alignedRect.size)
        case (.right, .left):
            let origin = CGPoint(
                x: aligningRect.minX - alignedRect.size.width,
                y: alignedRect.minY
            )
            return CGRect(origin: origin, size: alignedRect.size)
            
        case (.mid, .left):
            return CGRect(
                center: CGPoint(x: aligningRect.minX, y: alignedRect.midY),
                size: alignedRect.size
            )
        case (.mid, .mid):
            return CGRect(
                center: CGPoint(x: aligningRect.midX, y: alignedRect.midY),
                size: alignedRect.size
            )
        case (.mid, .right):
            return CGRect(
                center: CGPoint(x: aligningRect.maxX, y: alignedRect.midY),
                size: alignedRect.size
            )
        }
    }
}
