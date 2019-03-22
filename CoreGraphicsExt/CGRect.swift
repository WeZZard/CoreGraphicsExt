//
//  CGRect.swift
//  Core Graphics Extended Library
//
//  Created by WeZZard on 10/18/14.
//
//

import CoreGraphics

extension CGRect: CustomStringConvertible {
    public var description: String {
        return "<\(type(of: self)): X = \(self.origin.x), Y = \(self.origin.y), Width = \(self.width), Height = \(self.height)>"
    }
}

extension CGRect: Hashable {
    public var hashValue: Int {
        var hasher = Hasher()
        hasher.combine(origin.x)
        hasher.combine(origin.y)
        hasher.combine(size.width)
        hasher.combine(size.height)
        return hasher.finalize()
    }
}

/// Vertices on CGRect
extension CGRect {
    // Get the center of a CGRect value
    @_transparent
    public var center: CGPoint {
        get {
            return CGPoint(
                x: origin.x + size.width * 0.5,
                y: origin.y + size.height * 0.5
            )
        }
        set {
            origin = CGPoint(
                x: newValue.x - size.width * 0.5,
                y: newValue.y - size.height * 0.5
            )
        }
    }
    
    @_transparent
    public var topLeft: CGPoint { return vertex(.topLeft) }
    
    @_transparent
    public var bottomLeft: CGPoint { return vertex(.bottomLeft) }
    
    @_transparent
    public var bottomRight: CGPoint { return vertex(.bottomRight) }
    
    @_transparent
    public var topRight: CGPoint { return vertex(.topRight) }
}

public enum CGRectVertex: Int,
    CustomDebugStringConvertible,
    CustomStringConvertible
{
    case topLeft     = 0
    case bottomLeft  = 1
    case bottomRight = 2
    case topRight    = 3
    
    public func nextVertex(
        in direction: CGRectVertexIterateDirection
        )
        -> CGRectVertex
    {
        switch direction {
        case .clockwise:
            switch self {
            case .topLeft:      return .topRight
            case .topRight:     return .bottomRight
            case .bottomRight:  return .bottomLeft
            case .bottomLeft:   return .topLeft
            }
        case .counterClockwise:
            switch self {
            case .topLeft:      return .bottomLeft
            case .bottomLeft:   return .bottomRight
            case .bottomRight:  return .topRight
            case .topRight:     return .topLeft
            }
        }
    }
    
    public var description: String {
        switch self {
        case .topRight:     return "<\(type(of: self)): Top Right>"
        case .bottomRight:  return "<\(type(of: self)): Bottom Right>"
        case .bottomLeft:   return "<\(type(of: self)): Bottom Left>"
        case .topLeft:      return "<\(type(of: self)): Top Left>"
        }
    }
    
    public var debugDescription: String {
        return description
    }
    
    private class CGRectVertexIterator : IteratorProtocol {
        var rawValue = 0
        typealias Element = CGRectVertex
        func next() -> Element? {
            let element = CGRectVertex(rawValue: rawValue)
            rawValue += 1
            return element
        }
    }
    
    public static func enumerate() -> AnySequence<CGRectVertex> {
        return AnySequence({ CGRectVertexIterator() })
    }
}

public enum CGRectVertexIterateDirection: Int {
    case clockwise
    case counterClockwise
}

extension CGRect {
    // Get all the vertices on the rectangle
    public var vertices: AnySequence<(CGRectVertex, CGPoint)> {
        return vertices(in: .counterClockwise, startWith: .topLeft)
    }
    
    public func vertices(
        in direction: CGRectVertexIterateDirection,
        startWith fromPoint: CGPoint
        ) -> AnySequence<(CGRectVertex, CGPoint)>?
    {
        if let vertex = vertex(for: fromPoint) {
            return vertices(in: direction, startWith: vertex)
        }
        return nil
    }
    
    public func vertices(
        in direction: CGRectVertexIterateDirection,
        startWith fromVertex: CGRectVertex = .topLeft
        ) -> AnySequence<(CGRectVertex, CGPoint)>
    {
        var currentVertexOrNil: CGRectVertex? = nil
        return AnySequence<(CGRectVertex, CGPoint)>(
            AnyIterator {
                if let currentVertex = currentVertexOrNil {
                    if currentVertex == fromVertex {
                        return nil
                    } else {
                        let returnedVertex = currentVertex
                        let point = self.vertex(currentVertex)
                        currentVertexOrNil
                            = currentVertex.nextVertex(in: direction)
                        return (returnedVertex, point)
                    }
                } else {
                    currentVertexOrNil = fromVertex.nextVertex(
                        in: direction
                    )
                    return (fromVertex, self.vertex(fromVertex))
                }
            }
        )
    }
    
    public func vertex(for point: CGPoint) -> CGRectVertex? {
        for eachVertex in CGRectVertex.enumerate() {
            if point == vertex(eachVertex) {
                return eachVertex
            }
        }
        return nil
    }
}

public struct CGRectEdges: OptionSet, CustomStringConvertible {
    public typealias RawValue = UInt
    public var rawValue: RawValue
    public init(rawValue: RawValue) { self.rawValue = rawValue }
    
    public static let Top       = CGRectEdges(rawValue: 1 << 0)
    public static let Left      = CGRectEdges(rawValue: 1 << 1)
    public static let Bottom    = CGRectEdges(rawValue: 1 << 2)
    public static let Right     = CGRectEdges(rawValue: 1 << 3)
    
    public var description: String {
        var valueStrings: [String] = []
        if contains(.Top) { valueStrings.append(".Top") }
        if contains(.Left) { valueStrings.append(".Left") }
        if contains(.Bottom) { valueStrings.append(".Bottom") }
        if contains(.Right) { valueStrings.append(".Right") }
        let values = isEmpty ? ""
            : "; Values:\(valueStrings.joined(separator: " "))"
        return "<\(type(of: self).self): Raw Value = \(rawValue)\(values)>"
    }
}

extension CGRect {
    /// Create a CGRect value with the given size and (0,0) origin.
    public init(size aSize: CGSize) {
        let origin = CGPoint.zero
        let size = aSize
        self.init(origin: origin, size: size)
    }
    
    /// Create a CGRect value with the given center and size
    public init(center: CGPoint, size aSize: CGSize) {
        let origin = CGPoint(x: center.x - aSize.width * 0.5,
            y: center.y - aSize.height * 0.5)
        let size = aSize
        self.init(origin: origin, size: size)
    }
    
    /// Create a CGRect value with the given center, width and height
    public init(center: CGPoint, width: CGFloat, height: CGFloat) {
        let size = CGSize(width: width, height: height)
        let origin = CGPoint(x: center.x - size.width * 0.5,
            y: center.y - size.height * 0.5)
        self.init(origin: origin, size: size)
    }
    
    /// Create a CGRect value with the given CGRect which replace its origin or
    /// size if necessary
    public init(
        rect: CGRect,
        origin anOrigin: CGPoint? = nil,
        size aSize: CGSize? = nil
        )
    {
        let origin = anOrigin ?? rect.origin
        let size = aSize ?? rect.size
        self.init(origin: origin, size: size)
    }
}

extension CGRect {
    /// Create a CGRect value which covers all the given points
    @_transparent
    public init(points: CGPoint ...) {
        self = CGRect(points: points)
    }
    
    /// Create a CGRect value which covers all the given points
    @_transparent
    public init(points: [CGPoint]) {
        var x = [CGFloat]()
        x.reserveCapacity(points.count)
        var y = [CGFloat]()
        x.reserveCapacity(points.count)
        for point in points {
            x.append(point.x)
            y.append(point.y)
        }
        self = CGRect(x: &x, y: &y)
    }
    
    /// Create a CGRect value which covers all the given rects
    @_transparent
    public init(rects: CGRect...) {
        self = CGRect(rects: rects)
    }
    
    /// Create a CGRect value which covers all the given rects
    @_transparent
    public init(rects: [CGRect]) {
        var x = [CGFloat]()
        x.reserveCapacity(4 * rects.count)
        var y = [CGFloat]()
        x.reserveCapacity(4 * rects.count)
        for rect in rects {
            for (_, rectVertices) in rect.vertices {
                x.append(rectVertices.x)
                y.append(rectVertices.y)
            }
        }
        self = CGRect(x: &x, y: &y)
    }
    
    @_transparent
    public init(x: inout [CGFloat], y: inout [CGFloat]) {
        x.sort(); y.sort()
        assert(x.reduce(true, {$0 && $1 != .infinity}) && y.reduce(true, {$0 && $1 != .infinity}), "Value with infinity is not allowed")
        self = CGRect(
            x: x.min()!, y: y.min()!,
            width: x.max()! - x.min()!,
            height: y.max()! - y.min()!
        )
    }
}

extension CGRect {
    /// Return a CGRect value whose origin replaced by the given origin
    @_transparent
    public func replacedBy(origin: CGPoint) -> CGRect {
        return CGRect(origin: origin, size: size)
    }
    
    /// Replace rect's origin
    @_transparent
    public mutating func replace(origin: CGPoint) {
        self.origin = origin
    }
    
    /// Return a CGRect value whose origin x replaced by the given origin x
    @_transparent
    public func replacedBy(x: CGFloat) -> CGRect {
        return CGRect(origin: origin.replacedBy(x: x), size: size)
    }
    
    /// Replace rect's origin x
    @_transparent
    public mutating func replace(x: CGFloat) {
        origin.x = x
    }
    
    /// Return a CGRect value whose origin y replaced by the given origin y
    @_transparent
    public func replacedBy(y: CGFloat) -> CGRect {
        return CGRect(origin: origin.replacedBy(y: y), size: size)
    }
    
    /// Replace rect's origin y
    @_transparent
    public mutating func replace(y: CGFloat) {
        origin.y = y
    }
}


extension CGRect {
    /// Return a CGRect value whose size replaced by the given size
    @_transparent
    public func replacedBy(size: CGSize) -> CGRect {
        return CGRect(origin: origin, size: size)
    }
    
    /// Replace rect's size
    @_transparent
    public mutating func replace(size: CGSize) {
        self.size = size
    }
    
    /// Return a CGRect value whose width replaced by the given width
    @_transparent
    public func replacedBy(width: CGFloat) -> CGRect {
        return CGRect(origin: origin, size: size.replacedBy(width: width))
    }
    
    /// Replace rect's size
    @_transparent
    public mutating func replace(width: CGFloat) {
        size.width = width
    }
    
    /// Return a CGRect value whose width replaced by the given width
    @_transparent
    public func replacedBy(height: CGFloat) -> CGRect {
        return CGRect(origin: origin, size: size.replacedBy(height: height))
    }
    
    /// Replace rect's size
    @_transparent
    public mutating func replace(height: CGFloat) {
        size.height = height
    }
}

extension CGRect {
    /// Replace rect's size
    @_transparent
    public mutating func offset(dx: CGFloat, dy: CGFloat) {
        self.origin.x += dx
        self.origin.y += dy
    }
}

extension CGRect {
    /// Return a rect which guarantees the size is at leat equal to the given
    /// size. Enlarge around the rect center if needed.
    @_transparent
    public func guaranteed(size: CGSize) -> CGRect {
        return guaranteed(width: size.width, height: size.height)
    }
    
    /// Make the rect which guarantees the size is at leat equal to the given
    /// size. Enlarge around the rect center if needed.
    @_transparent
    public func guaranteed(width: CGFloat, height: CGFloat)
        -> CGRect
    {
        return CGRect(
            center: center,
            size: CGSize(
                width: max(self.width, width),
                height: max(self.height, height)
            )
        )
    }
    
    /// Return a rect which guarantees the size is at leat equal to the given
    /// size. Enlarge around the rect center if needed.
    @_transparent
    public mutating func guarantee(size: CGSize) {
        self = guaranteed(width: size.width, height: size.height)
    }
    
    /// Make the rect which guarantees the size is at leat equal to the given
    /// size. Enlarge around the rect center if needed.
    @_transparent
    public mutating func guarantee(width: CGFloat, height: CGFloat) {
        self = guaranteed(width: width, height: height)
    }
    
    /// Return a rect which guarantees the size is at leat equal to the given
    /// size. Enlarge around the rect center if needed.
    @_transparent
    @available(*, deprecated, renamed: "guaranteed(size:)")
    public func guaranteeSize(_ size: CGSize) -> CGRect {
        return guaranteed(width: size.width, height: size.height)
    }
    
    /// Make the rect which guarantees the size is at leat equal to the given
    /// size. Enlarge around the rect center if needed.
    @_transparent
    @available(*, deprecated, renamed: "guaranteed(width:height:)")
    public func guaranteeSize(width: CGFloat, height: CGFloat)
        -> CGRect
    {
        return guaranteed(width: width, height: height)
    }
    
    /// Return a rect which guarantees the size is at leat equal to the given
    /// size. Enlarge around the rect center if needed.
    @_transparent
    @available(*, deprecated, renamed: "guarantee(size:)")
    public mutating func guaranteeSizeInPlace(_ size: CGSize) {
        guarantee(width: size.width, height: size.height)
    }
    
    /// Make the rect which guarantees the size is at leat equal to the given
    /// size. Enlarge around the rect center if needed.
    @_transparent
    @available(*, deprecated, renamed: "guarantee(width:height:)")
    public mutating func guaranteeSizeInPlace(
        width: CGFloat,
        height: CGFloat
        )
    {
        guarantee(width: width, height: height)
    }
}

extension CGRect {
    /// Return a CGRect value whose width and height has been swapped
    public func bySwappingDimensions() -> CGRect {
        return CGRect(x: origin.x, y: origin.y, width: size.height, height: size.width);
    }
    
    /// Swap rect's width and height
    public mutating func swapDimensions() {
        self.size = self.size.swapDimensions()
    }
}

extension CGRect {
    /// Create a rect with a given porpotion which separates two rects
    public init(
        r1: CGRect, proportion1: CGFloat,
        r2: CGRect, proportion2: CGFloat
        )
    {
        let origin = CGPoint(
            p1: r1.origin, proportion1: proportion1,
            p2: r2.origin, proportion2: proportion2
        )
        let size = CGSize(
            s1: r1.size, proportion1: proportion1,
            s2: r2.size, proportion2: proportion2
        )
        self.init(origin: origin, size: size)
    }
}

extension CGRect {
    /// Check if the rectangle touches the given rectangle
    public func touches(_ rect: CGRect) -> Bool {
        return !((maxX < rect.minX || minX > rect.maxX) ||
            (maxY < rect.minY || minY > rect.maxY))
    }
}

//MARK: Align with CGRect
public protocol CGRectAnchor {
    func rectyByAligning(
        _ alignedRect: CGRect,
        and side: Self,
        on aligningRect: CGRect
        )
        -> CGRect
}

extension CGRect {
    public mutating func align(
        _ anchor: CGRectVerticalAnchor,
        and anotherAnchor: CGRectVerticalAnchor,
        on aligningRect: CGRect
        )
    {
        self = anchor.rectyByAligning(
            self, and: anotherAnchor, on: aligningRect
        )
    }
    
    public func aligning(
        _ anchor: CGRectVerticalAnchor,
        and anotherAnchor: CGRectVerticalAnchor,
        on aligningRect: CGRect
        )
        -> CGRect
    {
        return anchor.rectyByAligning(
            self, and: anotherAnchor, on: aligningRect
        )
    }
    
    public mutating func align(
        _ anchor: CGRectHorizontalAnchor,
        and anotherAnchor: CGRectHorizontalAnchor,
        on aligningRect: CGRect
        )
    {
        self = anchor.rectyByAligning(
            self, and: anotherAnchor, on: aligningRect
        )
    }
    
    public func aligning(
        _ anchor: CGRectHorizontalAnchor,
        and anotherAnchor: CGRectHorizontalAnchor,
        on aligningRect: CGRect
        )
        -> CGRect
    {
        return anchor.rectyByAligning(
            self, and: anotherAnchor, on: aligningRect
        )
    }
}

public enum CGRectVerticalAnchor: Int, CGRectAnchor {
    case top, mid, bottom
}

public enum CGRectHorizontalAnchor: Int, CGRectAnchor {
    case left, mid, right
}

//MARK: Operate with CGRect
public func + (lhs: CGRect, rhs: CGRect) -> CGRect {
    return CGRect(
        x: lhs.origin.x + rhs.origin.x,
        y: lhs.origin.y + rhs.origin.y,
        width: lhs.width + rhs.width,
        height: lhs.height + rhs.height
    )
}

public func += (lhs: inout CGRect, rhs: CGRect) {
    lhs = CGRect(
        x: lhs.origin.x + rhs.origin.x,
        y: lhs.origin.y + rhs.origin.y,
        width: lhs.width + rhs.width,
        height: lhs.height + rhs.height
    )
}

public func - (lhs: CGRect, rhs: CGRect) -> CGRect {
    return CGRect(
        x: lhs.origin.x - rhs.origin.x,
        y: lhs.origin.y - rhs.origin.y,
        width: lhs.width - rhs.width,
        height: lhs.height - rhs.height
    )
}

public func -= (lhs: inout CGRect, rhs: CGRect) {
    lhs = CGRect(
        x: lhs.origin.x - rhs.origin.x,
        y: lhs.origin.y - rhs.origin.y,
        width: lhs.width - rhs.width,
        height: lhs.height - rhs.height
    )
}

//MARK: Operate with CGPoint
public func + (lhs: CGRect, rhs: CGPoint) -> CGRect {
    return CGRect(
        x: lhs.origin.x + rhs.x,
        y: lhs.origin.y + rhs.y,
        width: lhs.width,
        height: lhs.height
    )
}

public func += (lhs: inout CGRect, rhs: CGPoint) {
    lhs = CGRect(
        x: lhs.origin.x + rhs.x,
        y: lhs.origin.y + rhs.y,
        width: lhs.width,
        height: lhs.height
    )
}

public func - (lhs: CGRect, rhs: CGPoint) -> CGRect {
    return CGRect(
        x: lhs.origin.x - rhs.x,
        y: lhs.origin.y - rhs.y,
        width: lhs.width,
        height: lhs.height
    )
}

public func -= (lhs: inout CGRect, rhs: CGPoint) {
    lhs = CGRect(
        x: lhs.origin.x - rhs.x,
        y: lhs.origin.y - rhs.y,
        width: lhs.width,
        height: lhs.height
    )
}

//MARK: Operate with CGSize
public func + (lhs: CGRect, rhs: CGSize) -> CGRect {
    return CGRect(
        x: lhs.origin.x,
        y: lhs.origin.y,
        width: lhs.width + rhs.width,
        height: lhs.height + rhs.height
    )
}

public func += (lhs: inout CGRect, rhs: CGSize) {
    lhs = CGRect(
        x: lhs.origin.x,
        y: lhs.origin.y,
        width: lhs.width + rhs.width,
        height: lhs.height + rhs.height
    )
}

public func - (lhs: CGRect, rhs: CGSize) -> CGRect {
    return CGRect(
        x: lhs.origin.x,
        y: lhs.origin.y,
        width: lhs.width - rhs.width,
        height: lhs.height - rhs.height
    )
}

public func -= (lhs: inout CGRect, rhs: CGSize) {
    lhs = CGRect(
        x: lhs.origin.x,
        y: lhs.origin.y,
        width: lhs.width - rhs.width,
        height: lhs.height - rhs.height
    )
}
