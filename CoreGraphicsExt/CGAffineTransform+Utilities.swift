//
//  CGAffineTransform+Calculation.swift
//  CoreGraphicsExt
//
//  Created by WeZZard on 1/29/16.
//
//

import CoreGraphics

//MARK: Creations
extension CGAffineTransform {
    public static func translation(x: CGFloat, y: CGFloat)
        -> CGAffineTransform
    {
        return CGAffineTransform(translationX: x, y: y)
    }
    
    public static func translation(x: Double, y: Double) -> CGAffineTransform {
        return CGAffineTransform(translationX: CGFloat(x), y: CGFloat(y))
    }
    
    public static func translation(x: Float, y: Float) -> CGAffineTransform {
        return CGAffineTransform(translationX: CGFloat(x), y: CGFloat(y))
    }
    
    public static func translation(x: Int, y: Int) -> CGAffineTransform {
        return CGAffineTransform(translationX: CGFloat(x), y: CGFloat(y))
    }
    
    public static func translation(point: CGPoint) -> CGAffineTransform {
        return CGAffineTransform(translationX: point.x, y: point.y)
    }
    
    public static func translation(size: CGSize) -> CGAffineTransform {
        return CGAffineTransform(translationX: size.width, y: size.height)
    }
    
    public static func translation(vector: CGVector) -> CGAffineTransform {
        return CGAffineTransform(translationX: vector.dx, y: vector.dy)
    }
    
    public static func scale(x: CGFloat, y: CGFloat) -> CGAffineTransform {
        return CGAffineTransform(scaleX: x, y: y)
    }
    
    public static func scale(x: Double, y: Double) -> CGAffineTransform {
        return CGAffineTransform(scaleX: CGFloat(x), y: CGFloat(y))
    }
    
    public static func scale(x: Float, y: Float) -> CGAffineTransform {
        return CGAffineTransform(scaleX: CGFloat(x), y: CGFloat(y))
    }
    
    public static func scale(x: Int, y: Int) -> CGAffineTransform {
        return CGAffineTransform(scaleX: CGFloat(x), y: CGFloat(y))
    }
    
    public static func scale(all: Double) -> CGAffineTransform {
        return CGAffineTransform(scaleX: CGFloat(all), y: CGFloat(all))
    }
    
    public static func scale(all: Float) -> CGAffineTransform {
        return CGAffineTransform(scaleX: CGFloat(all), y: CGFloat(all))
    }
    
    public static func scale(all: Int) -> CGAffineTransform {
        return CGAffineTransform(scaleX: CGFloat(all), y: CGFloat(all))
    }
    
    public static func rotation(angle: CGFloat) -> CGAffineTransform {
        return CGAffineTransform(rotationAngle: angle)
    }
    
    public static func rotation(angle: Float) -> CGAffineTransform {
        return CGAffineTransform(rotationAngle: CGFloat(angle))
    }
    
    public static func rotation(angle: Double) -> CGAffineTransform {
        return CGAffineTransform(rotationAngle: CGFloat(angle))
    }
    
    public static func rotation(angle: Int) -> CGAffineTransform {
        return CGAffineTransform(rotationAngle: CGFloat(angle))
    }
}

//MARK: Calculations
extension CGAffineTransform {
    public mutating func translate(x: CGFloat, y: CGFloat) {
        self = self.translatedBy(x: x, y: y)
    }
    
    public mutating func translate(x: Double, y: Double) {
        self = self.translatedBy(x: CGFloat(x), y: CGFloat(y))
    }
    
    public mutating func translate(x: Float, y: Float) {
        self = self.translatedBy(x: CGFloat(x), y: CGFloat(y))
    }
    
    public mutating func scale(x: CGFloat, y: CGFloat) {
        self = self.scaledBy(x: x, y: y)
    }
    
    public mutating func scale(x: Double, y: Double) {
        self = self.scaledBy(x: CGFloat(x), y: CGFloat(y))
    }
    
    public mutating func scale(x: Float, y: Float) {
        self = self.scaledBy(x: CGFloat(x), y: CGFloat(y))
    }
    
    public mutating func rotate(angle: CGFloat) {
        self = self.rotated(by: angle)
    }
    
    public mutating func rotate(angle: Double) {
        self = self.rotated(by: CGFloat(angle))
    }
    
    public mutating func rotate(angle: Float) {
        self = self.rotated(by: CGFloat(angle))
    }
    
    public mutating func invert() {
        self = self.inverted()
    }
}

//MARK: Operators
public func || (lhs: CGAffineTransform, rhs: CGAffineTransform)
    -> CGAffineTransform
{
    return lhs.concatenating(rhs)
}
