//
//  CGRect+Edges.swift
//  CoreGraphicsExt
//
//  Created by WeZZard on 3/20/16.
//
//

import CoreGraphics

extension CGRect {
    @_transparent
    public func edgesForPoint(_ point: CGPoint) -> CGRectEdges {
        var edges: CGRectEdges = []
        
        if point.x == minX { edges.insert(.Left) }
        
        if point.x == maxX { edges.insert(.Right) }
        
        if point.y == minY { edges.insert(.Top) }
        
        if point.y == maxY { edges.insert(.Bottom) }
        
        return edges
    }
}
