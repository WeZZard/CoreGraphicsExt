//
//  CGVector.swift
//  CoreGraphicsExt
//
//  Created by WeZZard on 1/29/16.
//
//

import CoreGraphics

extension CGVector: Hashable {
    public var hashValue: Int {
        var hasher = Hasher()
        hasher.combine(dx)
        hasher.combine(dy)
        return hasher.finalize()
    }
}

public func + (lhs: CGVector, rhs: CGVector) -> CGVector {
    return CGVector(dx: lhs.dx + rhs.dx, dy: lhs.dy + rhs.dy)
}

public func += (lhs: inout CGVector, rhs: CGVector) {
    lhs = CGVector(dx: lhs.dx + rhs.dx, dy: lhs.dy + rhs.dy)
}

public func - (lhs: CGVector, rhs: CGVector) -> CGVector {
    return CGVector(dx: lhs.dx - rhs.dx, dy: lhs.dy - rhs.dy)
}

public func -= (lhs: CGVector, rhs: inout CGVector) {
    rhs = CGVector(dx: lhs.dx - rhs.dx, dy: lhs.dy - rhs.dy)
}

public func * (lhs: CGVector, rhs: CGFloat) -> CGVector {
    return CGVector(dx: lhs.dx * rhs, dy: lhs.dy * rhs)
}

public func *= (lhs: inout CGVector, rhs: CGFloat) {
    lhs = CGVector(dx: lhs.dx * rhs, dy: lhs.dy * rhs)
}

public func * (lhs: CGFloat, rhs: CGVector) -> CGVector {
    return CGVector(dx: lhs * rhs.dx, dy: lhs * rhs.dy)
}

public func * (lhs: CGVector, rhs: CGVector) -> CGFloat {
    return  lhs.dx * rhs.dx + lhs.dy * rhs.dy
}

public func / (lhs: CGVector, rhs: CGFloat) -> CGVector {
    return CGVector(dx: lhs.dx / rhs, dy: lhs.dy / rhs)
}

public func /= (lhs: inout CGVector, rhs: CGFloat) {
    lhs = CGVector(dx: lhs.dx / rhs, dy: lhs.dy / rhs)
}

public prefix func -(p: CGVector) -> CGVector {
    return CGVector(dx: p.dx, dy: p.dy)
}
