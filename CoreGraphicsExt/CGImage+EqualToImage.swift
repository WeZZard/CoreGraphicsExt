//
//  CGImage+EqualToImage.swift
//  CoreGraphicsExt
//
//  Created by WeZZard on 11/25/15.
//
//

import CoreGraphics
#if os(iOS) || os(tvOS) || os(watchOS)
    import UIKit
#elseif os(OSX)
    import AppKit
#endif

extension CGImage {
    public func isEqualToImage(_ image: CGImage) -> Bool {
        if self === image { return true }
        
        #if os(iOS) || os(tvOS) || os(watchOS)
        let lhsUIImage = UIImage(cgImage: self)
        let rhsUIImage = UIImage(cgImage: image)
        
        guard let lhsPNGData = UIImagePNGRepresentation(lhsUIImage),
            let rhsPNGData = UIImagePNGRepresentation(rhsUIImage) else
        {
            return false
        }
        
        return (lhsPNGData == rhsPNGData)
        #elseif os(OSX)
        let lhsSize = CGSize(width: CGFloat(width),
                             height: CGFloat(height))
        let rhsSize = CGSize(width: CGFloat(image.width),
                             height: CGFloat(image.height))
        
        let lhsNSImage = NSImage(cgImage: self, size: lhsSize)
        let rhsNSImage = NSImage(cgImage: self, size: rhsSize)
        
        guard let lhsTIFFData = lhsNSImage.tiffRepresentation,
            let rhsTIFFData = rhsNSImage.tiffRepresentation else
        {
            return false
        }
        
        return lhsTIFFData == rhsTIFFData
        #endif
    }
}
