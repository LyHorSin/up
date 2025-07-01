//
//  Numeric+Ex.swift
//  up
//
//  Created by Chanon Latt on 8/9/24.
//

import Foundation

extension Numeric {
    func toString() -> String {
        return String(describing: self)
    }
}

extension BinaryFloatingPoint {
    
    var pxw: CGFloat {
        sizing(pixels: CGFloat(self)).width
    }
    
    var pxh: CGFloat {
        sizing(pixels: CGFloat(self)).height
    }
    
    var px: CGFloat {
        sizing(pixels: CGFloat(self)).width
    }
}

extension BinaryInteger {
    var px: CGFloat {
        sizing(pixels: CGFloat(self)).width
    }
    
    var pxw: CGFloat {
        sizing(pixels: CGFloat(self)).width
    }
    
    var pxh: CGFloat {
        sizing(pixels: CGFloat(self)).height
    }
}
