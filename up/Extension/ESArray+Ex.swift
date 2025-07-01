//
//  ESArray+Ex.swift
//  up
//
//  Created by Ly Hor Sin on 9/10/24.
//

import Foundation
extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
 }

// Helper extension to remove duplicates
extension Array where Element: Hashable {
    func unique() -> [Element] {
        var set = Set<Element>()
        return filter { set.insert($0).inserted }
    }
    
    mutating func appendAndReplace(_ element: Element) {
        self.removeAll(where: { $0 == element})
        self.append(element)
    }
}

extension Array where Element: Equatable {
    mutating func remove(_ element: Element) {
        self.removeAll(where: { $0 == element})
    }
}
