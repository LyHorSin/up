//
//  ESDictionary+Ex.swift
//  up
//
//  Created by Chanon Latt on 10/26/24.
//

import Foundation

extension Dictionary where Key == String, Value == Any {
    func toParamsString() -> String {
        return self.compactMap { key, value in
            // Ensure the value can be represented as a string
            if let escapedKey = key.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
               let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                return "\(escapedKey)=\(escapedValue)"
            }
            return nil
        }.joined(separator: "&")
    }
}

