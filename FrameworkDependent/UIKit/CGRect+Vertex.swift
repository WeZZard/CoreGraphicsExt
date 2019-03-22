//
//  CGRect+Vertex.swift
//  CoreGraphicsExt
//
//  Created by WeZZard on 2/16/16.
//
//

import CoreGraphics

extension CGRect {
    /// Get the specific vertex on the rectangle
    @_transparent
    public func vertex(_ vertex: CGRectVertex) -> CGPoint {
        switch vertex {
        case .topRight:
            return CGPoint(x: maxX, y: minY);
        case .bottomRight:
            return CGPoint(x: maxX, y: maxY);
        case .bottomLeft:
            return CGPoint(x: minX, y: maxY);
        case .topLeft:
            return CGPoint(x: minX, y: minY);
        }
    }
}
