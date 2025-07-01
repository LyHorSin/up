//
//  ESDouble+Ex.swift
//  up
//
//  Created by SINN SOKLYHOR on 28/4/24.
//

import Foundation

extension Double {
    
    public func toString() -> String {
        return "\(self)"
    }
    
    public func rounded(digit: Int = 2) -> String {
        return "\(String(format: "%.\(digit)f", self))"
    }
    
    public func toPrice(symbol: String = "$", withSpacing: Bool = true) -> String {
        return "\(symbol)\(withSpacing ? " ": "")\(String(format: "%.2f", self))"
    }
    
    public func toPriceFormat(symbol: String = "$") -> String {
        if floor(self) == self {
            return "\(symbol)\(String(format: "%.0f", floor(self)))"
        } else {
            return "\(symbol)\(String(format: "%.2f", self))"
        }
    }
    
    public func toIntPrice(symbol: String = "$") -> String {
        return "\(symbol)\(String(format: "%.0f", floor(self)))"
    }
    
    public func toPercentages() -> String {
        return "\(String(format: "%.0f", self))%"
    }
    
    public func toPriceK() -> String {
        let absPrice = abs(self)
        let sign = (self < 0) ? "-" : ""
        
        if absPrice >= 1000000 {
            return String(format: "\(sign)%.2fm", self / 1000000)
        } else if absPrice >= 1000 {
            return String(format: "\(sign)%.2fk", self / 1000)
        } else {
            return String(format: "\(sign)%.2f", self)
        }
    }
    
    public func toKilometer() -> String {
        return "\(String(format: "%.2f", self)) Km"
    }
    
    public func toStar() -> String {
        if floor(self) == self {
            return "\(String(format: "%.1f", floor(self)))"
        } else {
            return "\(String(format: "%.1f", self))"
        }
    }
    
    public func toStarFloor() -> String {
        return "\(String(format: "%.0f", floor(self)))"
    }
    
    public func toBalanceFormat() -> String {
        if floor(self) == self {
            return "\(String(format: "%.0f", floor(self)))"
        } else {
            return "\(String(format: "%.1f", self))"
        }
    }
}
