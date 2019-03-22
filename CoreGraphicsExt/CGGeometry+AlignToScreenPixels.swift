//
//  CGGeometry+AlignToScreenPixels.swift
//  Core-Graphics-Extended-Library
//
//  Created by WeZZard on 7/6/15.
//
//

import CoreGraphics

public enum CGLinearScreenPixelAlignment: Int {
    case ceil, floor, round
}

public enum CGArealScreenPixelAlignment: Int {
    case extend, round, shrink
}

extension CGFloat {
    public func alignToScreenPixels(
        _ alignment: CGLinearScreenPixelAlignment = .round
        )
        -> CGFloat
    {
        if let scale = CGScreenScale {
            switch alignment {
            case .ceil:
                return CoreGraphics.ceil(self * scale) / scale
            case .floor:
                return CoreGraphics.ceil(self * scale) / scale
            case .round:
                return CoreGraphics.round(self * scale) / scale
            }
        }
        return CGFloat(Int(self))
    }
}

extension CGPoint {
    public func alignToScreenPixels(
        _ alignment: CGLinearScreenPixelAlignment = .round
        )
        -> CGPoint
    {
        if let screenScale = CGScreenScale {
            switch alignment {
            case .ceil:
                return CGPoint(
                    x: ceil(x * screenScale) / screenScale,
                    y: ceil(y * screenScale) / screenScale
                )
            case .floor:
                return CGPoint(
                    x: floor(x * screenScale) / screenScale,
                    y: floor(y * screenScale) / screenScale
                )
            case .round:
                return CGPoint(
                    x: round(x * screenScale) / screenScale,
                    y: round(y * screenScale) / screenScale
                )
            }
        } else {
            return CGPoint(x: Int(x), y: Int(y))
        }
    }
}

extension CGSize {
    public func alignToScreenPixels(
        _ alignment: CGLinearScreenPixelAlignment = .round
        )
        -> CGSize
    {
        if let screenScale = CGScreenScale {
            switch alignment {
            case .ceil:
                return CGSize(
                    width: ceil(width * screenScale) / screenScale,
                    height: ceil(height * screenScale) / screenScale
                )
            case .floor:
                return CGSize(
                    width: floor(width * screenScale) / screenScale,
                    height: floor(height * screenScale) / screenScale
                )
            case .round:
                return CGSize(
                    width: round(width * screenScale) / screenScale,
                    height: round(height * screenScale) / screenScale
                )
            }
        } else {
            return CGSize(width: Int(width), height: Int(height))
        }
    }
}

extension CGRect {
    #if os(iOS) || os(tvOS) || os(watchOS)
    public func alignToScreenPixels(
        _ alignment: CGArealScreenPixelAlignment = .extend
        )
        -> CGRect
    {
        if let screenScale = CGScreenScale {
            switch alignment {
            case .extend:
                return CGRect(
                    x: floor(origin.x * screenScale) / screenScale,
                    y: floor(origin.y * screenScale) / screenScale,
                    width: ceil(size.width * screenScale) / screenScale,
                    height: ceil(size.height * screenScale) / screenScale
                )
            case .round:
                return CGRect(
                    x: round(origin.x * screenScale) / screenScale,
                    y: round(origin.y * screenScale) / screenScale,
                    width: round(size.width * screenScale) / screenScale,
                    height: round(size.height * screenScale) / screenScale
                )
            case .shrink:
                return CGRect(
                    x: ceil(origin.x * screenScale) / screenScale,
                    y: ceil(origin.y * screenScale) / screenScale,
                    width: floor(size.width * screenScale) / screenScale,
                    height: floor(size.height * screenScale) / screenScale
                )
            }
        } else {
            return CGRect(
                x: Int(origin.x), y: Int(origin.y),
                width: Int(width), height: Int(height)
            )
        }
    }
    #elseif os(OSX)
    public func alignToScreenPixels(
        alignment: CGArealScreenPixelAlignment = .extend
        )
        -> CGRect
    {
        if let screenScale = CGScreenScale {
            switch alignment {
            case .extend:
                return CGRect(
                    x: ceil(origin.x * screenScale) / screenScale,
                    y: ceil(origin.y * screenScale) / screenScale,
                    width: floor(size.width * screenScale) / screenScale,
                    height: floor(size.height * screenScale) / screenScale
                )
            case .round:
                return CGRect(
                    x: round(origin.x * screenScale) / screenScale,
                    y: round(origin.y * screenScale) / screenScale,
                    width: round(size.width * screenScale) / screenScale,
                    height: round(size.height * screenScale) / screenScale
                )
            case .shrink:
                return CGRect(
                    x: floor(origin.x * screenScale) / screenScale,
                    y: floor(origin.y * screenScale) / screenScale,
                    width: ceil(size.width * screenScale) / screenScale,
                    height: ceil(size.height * screenScale) / screenScale
                )
            }
        } else {
            return CGRect(
                x: Int(origin.x), y: Int(origin.y),
                width: Int(width), height: Int(height)
            )
        }
    }
    #endif
}
