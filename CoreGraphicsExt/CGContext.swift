//
//  CGContext.swift
//  CoreGraphicsExt
//
//  Created by WeZZard on 23/01/2017.
//
//

import CoreGraphics

extension CGContext {
    public func withTransientGraphicsState(_ closure: (_: CGContext) -> Void) {
        saveGState()
        closure(self)
        restoreGState()
    }
    
    public func withTransparentLayer(
        in rect: CGRect,
        auxiliaryInfo: CFDictionary?,
        _ closure: (_: CGContext) -> Void
        )
    {
        beginTransparencyLayer(in: rect, auxiliaryInfo: auxiliaryInfo)
        closure(self)
        endTransparencyLayer()
    }
    
    public func withTransparentLayer(
        auxiliaryInfo: CFDictionary?,
        _ closure: (_: CGContext) -> Void
        )
    {
        beginTransparencyLayer(auxiliaryInfo: auxiliaryInfo)
        closure(self)
        endTransparencyLayer()
    }
}
