//
//  ShapeRoundedCorner.swift
//  up
//
//  Created by Ly Hor Sin on 17/7/25.
//

import SwiftUI

struct ShapeRoundedCorner: Shape {
    var topLeftRadius: CGFloat = 0
    var topRightRadius: CGFloat = 0
    var bottomLeftRadius: CGFloat = 0
    var bottomRightRadius: CGFloat = 0

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath()
        
        // Start at top left
        path.move(to: CGPoint(x: rect.minX + topLeftRadius, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX - topRightRadius, y: rect.minY))
        path.addQuadCurve(to: CGPoint(x: rect.maxX, y: rect.minY + topRightRadius), controlPoint: CGPoint(x: rect.maxX, y: rect.minY))
        
        // Right side
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - bottomRightRadius))
        path.addQuadCurve(to: CGPoint(x: rect.maxX - bottomRightRadius, y: rect.maxY), controlPoint: CGPoint(x: rect.maxX, y: rect.maxY))
        
        // Bottom side
        path.addLine(to: CGPoint(x: rect.minX + bottomLeftRadius, y: rect.maxY))
        path.addQuadCurve(to: CGPoint(x: rect.minX, y: rect.maxY - bottomLeftRadius), controlPoint: CGPoint(x: rect.minX, y: rect.maxY))
        
        // Left side
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + topLeftRadius))
        path.addQuadCurve(to: CGPoint(x: rect.minX + topLeftRadius, y: rect.minY), controlPoint: CGPoint(x: rect.minX, y: rect.minY))

        return Path(path.cgPath)
    }
}
