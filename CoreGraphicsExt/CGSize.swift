//
//  CGSize.swift
//  Core Graphics Extended Library
//
//  Created by WeZZard on 10/18/14.
//
//

import CoreGraphics

extension CGSize: CustomStringConvertible {
    public var description: String {
        return "<\(type(of: self)): Width = \(self.width), Height = \(self.height)>"
    }
}

extension CGSize: Hashable {
    public var hashValue: Int {
        var hasher = Hasher()
        hasher.combine(width)
        hasher.combine(height)
        return hasher.finalize()
    }
}

extension CGSize {
    public func addedBy(width: CGFloat) -> CGSize {
        return CGSize(width: self.width + width, height: height)
    }
    
    public func addedBy(height: CGFloat) -> CGSize {
        return CGSize(width: width, height: self.height + height)
    }
    
    /// Return a point with given x and original y
    public func replacedBy(width: CGFloat) -> CGSize {
        return CGSize(width: width, height: height)
    }
    
    /// Return a point with original x and given y
    public func replacedBy(height: CGFloat) -> CGSize {
        return CGSize(width: width, height: height)
    }
}

extension CGSize {
    /// Create a CGSize value with maximum width and height
    public static var max: CGSize {
        return CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
    }
}

extension CGSize {
    /// Get minimum side length
    public var minSideLength: CGFloat {
        return Swift.min(width, height)
    }
    
    /// Get maximum side length
    public var maxSideLength: CGFloat {
        return Swift.max(width, height)
    }
    
    /// Integral
    public var integral: CGSize {
        return CGSize(width: ceil(width), height: ceil(height))
    }
    
    /// Swap width and height
    public func swapDimensions() -> CGSize {
        return CGSize(width: height, height: width)
    }
    
    /// Swap width and height in place
    public mutating func swapDimensionsInPlace() {
        self = CGSize(width: height, height: width)
    }
    
    public func contains(_ size: CGSize) -> Bool {
        return width >= size.width && height >= size.height
    }
}

extension CGSize {
    /// Create a size with a given porpotion which separates two sizes
    public init(
        s1: CGSize, proportion1: CGFloat, 
        s2: CGSize, proportion2: CGFloat
        )
    {
        
        if proportion2 == 0 {
            self = s2
        } else {
            let width1 = s1.width
            let height1 = s1.height
            let width2 = s2.width
            let height2 = s2.height
            
            let mix = proportion1 / proportion2
            
            let width = (width1 + mix * width2) / (1 + mix)
            let height = (height1 + mix * height2) / (1 + mix)
            self.init(width: width, height: height)
        }
    }
}

public func + (lhs: CGSize, rhs: CGSize) -> CGSize {
    return CGSize(width: lhs.width + rhs.width,
        height: lhs.height + rhs.height)
}

public func += (lhs: inout CGSize, rhs: CGSize) {
    lhs = CGSize(width: lhs.width + rhs.width,
        height: lhs.height + rhs.height)
}

public func - (lhs: CGSize, rhs: CGSize) -> CGSize {
    return CGSize(width: lhs.width - rhs.width,
        height: lhs.height - rhs.height)
}

public func -= (lhs: inout CGSize, rhs: CGSize) {
    lhs = CGSize(width: lhs.width - rhs.width,
        height: lhs.height - rhs.height)
}

public func * (lhs: CGSize, rhs: CGFloat) -> CGSize {
    return CGSize(width: lhs.width * rhs,
        height: lhs.height * rhs)
}

public func *= (lhs: inout CGSize, rhs: CGFloat) {
    lhs = CGSize(width: lhs.width * rhs,
        height: lhs.height * rhs)
}

public func * (lhs: CGFloat, rhs: CGSize) -> CGSize {
    return CGSize(width: lhs * rhs.width,
        height: lhs * rhs.height)
}

public func / (lhs: CGSize, rhs: CGFloat) -> CGSize {
    return CGSize(width: lhs.width / rhs,
        height: lhs.height / rhs)
}

public func /= (lhs: inout CGSize, rhs: CGFloat) {
    lhs = CGSize(width: lhs.width / rhs,
        height: lhs.height / rhs)
}

public prefix func -(p: CGSize) -> CGSize {
    return CGSize(width: p.width, height: p.height)
}
