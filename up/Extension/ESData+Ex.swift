//
//  ESData+Ex.swift
//  up
//
//  Created by Ly Hor Sin on 17/6/24.
//

import Foundation

extension Data {
        
    public func toString() -> String? {
        return String(data: self, encoding: .utf8)
    }
}
