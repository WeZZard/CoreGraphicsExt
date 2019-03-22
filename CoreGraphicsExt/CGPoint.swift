//
//  CGPoint.swift
//  Core Graphics Extended Library
//
//  Createsd by WeZZard on 10/18/14.
//
//

import CoreGraphics

extension CGPoint: CustomStringConvertible {
    public var description: String {
        return "<\(type(of: self)): X = \(self.x), Y = \(self.y)>"
    }
}

extension CGPoint: Hashable {
    public var hashValue: Int {
        var hasher = Hasher()
        hasher.combine(x)
        hasher.combine(y)
        return hasher.finalize()
    }
}

extension CGPoint {
    /// Calculates distance from current point to given point
    @inline(__always)
    public func distance(to point : CGPoint) -> CGFloat {
        let x1 = x, x2 = point.x
        let y1 = y, y2 = point.y
        let xSquare = pow(x2 - x1, 2.0)
        let ySquare = pow(y2 - y1, 2.0)
        let delta = pow(xSquare + ySquare, 0.5)
        return delta
    }
    
    /// Checks if the point is inside the biggest circle which is inside the 
    /// given rectangle
    @inline(__always)
    public func inside(circleOf rect: CGRect) -> Bool {
        let minimumSideLength = min(rect.size.width, rect.size.height)
        return pow(x - rect.midX, 2) + pow(y - rect.midY, 2)
            < pow(minimumSideLength, 2)
    }
    
    /// Checks if the point is on the circumference of the biggest circle which
    /// is inside the given rectangle
    @inline(__always)
    public func on(circleOf rect: CGRect) -> Bool {
        let minimumSideLength = min(rect.size.width, rect.size.height)
        return pow(x - rect.midX, 2) + pow(y - rect.midY, 2)
            == pow(minimumSideLength, 2)
    }
    
    /// Checks if the point is on the circumference or inside the biggest circle
    /// which is inside the given rectangle
    @inline(__always)
    public func contained(inCircleOf rect: CGRect) -> Bool {
        let minimumSideLength = min(rect.size.width, rect.size.height)
        return pow(x - rect.midX, 2) + pow(y - rect.midY, 2)
            <= pow(minimumSideLength, 2)
    }
    
    /// Checks if the point is inside the given rectangle
    @inline(__always)
    public func inside(rect: CGRect) -> Bool {
        let pointX = x, pointY = y
        let leftBounds = rect.origin.x
        let rightBounds = rect.origin.x + rect.size.width
        let topBounds = rect.origin.y
        let bottomBounds = rect.origin.y + rect.size.height
        
        if ((pointX < rightBounds && pointX > leftBounds) &&
            (pointY < bottomBounds && pointY > topBounds))
        {
            return true
        }
        return false
    }
    
    /// Checks if the point is on the circumference of the given rectangle
    @inline(__always)
    public func on(rect: CGRect) -> Bool {
        let pointX = x, pointY = y
        let leftBounds = rect.origin.x
        let rightBounds = rect.origin.x + rect.size.width
        let topBounds = rect.origin.y
        let bottomBounds = rect.origin.y + rect.size.height
        
        if ((pointX == rightBounds && pointX == leftBounds) &&
            (pointY == bottomBounds && pointY == topBounds))
        {
            return true
        }
        return false
    }
    
    /// Checks if the point is on the circumference or inside the given 
    /// rectangle
    @inline(__always)
    public func contained(in rect: CGRect) -> Bool {
        let pointX = x, pointY = y
        let leftBounds = rect.origin.x
        let rightBounds = rect.origin.x + rect.size.width
        let topBounds = rect.origin.y
        let bottomBounds = rect.origin.y + rect.size.height
        
        if ((pointX <= rightBounds && pointX >= leftBounds) &&
            (pointY <= bottomBounds && pointY >= topBounds))
        {
            return true
        }
        return false
    }
    
    /// Calculates the mid point between the point and the given point
    @inline(__always)
    public func midPoint(to point: CGPoint) -> CGPoint {
        let x1 = self.x, x2 = point.x
        let y1 = self.y, y2 = point.y
        
        let midX = (x1 + x2) * 0.5, midY = (y1 + y2) * 0.5
        
        return CGPoint(x: midX, y: midY)
    }
    
    /// Creates a point by linear mixing two points.
    @inline(__always)
    public func mix(point: CGPoint, proportion: CGFloat) -> CGPoint {
        let x1 = x + (point.x - x) * proportion
        let y1 = y + (point.y - y) * proportion
        return CGPoint(x: x1, y: y1)
    }
    
    /// Creates a point with a given ratio which separates the origin the
    /// destination point
    @inline(__always)
    public init(
        p1: CGPoint, proportion1: CGFloat,
        p2: CGPoint, proportion2: CGFloat
        )
    {
        if proportion2 == 0 {
            self = p2
        } else {
            let x0 = p1.x, y0 = p1.y
            let x1 = p2.x, y1 = p2.y
            
            let mix = proportion1 / proportion2
            
            let x = (x0 + mix * x1) / (1 + mix)
            let y = (y0 + mix * y1) / (1 + mix)
            
            self.init(x: x, y: y)
        }
    }
    
    /// Creates a point with a given ratio which separates the origin the
    /// destination point
    @inline(__always)
    public init(p1: CGPoint, p2: CGPoint, ratio: CGFloat) {
        let x0 = p1.x, y0 = p1.y
        let x1 = p2.x, y1 = p2.y
        
        let x = (x0 + ratio * x1) / (1 + ratio)
        let y = (y0 + ratio * y1) / (1 + ratio)
        
        self.init(x: x, y: y)
    }
}

extension CGPoint {
    /// Return a point with given x and original y
    @inline(__always)
    public func replacedBy(x: CGFloat) -> CGPoint {
        return CGPoint(x: x, y: y)
    }
    
    /// Return a point with original x and given y
    @inline(__always)
    public func replacedBy(y: CGFloat) -> CGPoint {
        return CGPoint(x: x, y: y)
    }
    
    /// Return a point with given x and original y
    @inline(__always)
    public func addedBy(x d: CGFloat) -> CGPoint {
        return CGPoint(x: x + d, y: y)
    }
    
    /// Return a point with original x and given y
    @inline(__always)
    public func addedBy(y d: CGFloat) -> CGPoint {
        return CGPoint(x: x, y: y + d)
    }
}

public func + (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
}

public func += (lhs: inout CGPoint, rhs: CGPoint) {
    lhs = CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
}

public func - (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
}

public func -= (lhs: CGPoint, rhs: inout CGPoint) {
    rhs = CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
}

public func * (lhs: CGPoint, rhs: CGFloat) -> CGPoint {
    return CGPoint(x: lhs.x * rhs, y: lhs.y * rhs)
}

public func *= (lhs: inout CGPoint, rhs: CGFloat) {
    lhs = CGPoint(x: lhs.x * rhs, y: lhs.y * rhs)
}

public func * (lhs: CGFloat, rhs: CGPoint) -> CGPoint {
    return CGPoint(x: lhs * rhs.x, y: lhs * rhs.y)
}

public func * (lhs: CGPoint, rhs: CGPoint) -> CGFloat {
    return  lhs.x * rhs.x + lhs.y * rhs.y
}

public func / (lhs: CGPoint, rhs: CGFloat) -> CGPoint {
    return CGPoint(x: lhs.x / rhs, y: lhs.y / rhs)
}

public func /= (lhs: inout CGPoint, rhs: CGFloat) {
    lhs = CGPoint(x: lhs.x / rhs, y: lhs.y / rhs)
}

public prefix func -(p: CGPoint) -> CGPoint {
    return CGPoint(x: -p.x, y: -p.y)
}

