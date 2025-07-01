//
//  Optional+Ex.swift
//  up
//
//  Created by Chanon Latt on 7/9/24.
//

import Foundation
import SwiftyJSON

// MARK: - Optional

extension Optional {
    
    public var isNil: Bool {
        self == nil
    }
    
    public var isNotNil: Bool {
        !isNil
    }
}

// MARK: - Optional<String>

extension Optional where Wrapped == String {
    
    public func defaultValueIfNil(_ string: String) ->String {
        self ?? string
    }
    
    public var emptyStringIfNil: String {
        self ?? ""
    }
}

extension Optional where Wrapped: Collection {
    
    public var emptyValueIfNil: Wrapped {
        self ?? [] as! Wrapped
    }
    
    public var emptyValueIsNil: Wrapped {
        if let value = self {
            return value
        } else {
            if Wrapped.self == String.self {
                return "" as! Wrapped
            } else if Wrapped.self == [Any].self {
                return [] as! Wrapped
            } else {
                fatalError("Unsupported type for emptyValueIfNil")
            }
        }
    }
    
    public var isNilorEmpty: Bool {
        isNil || (self?.isEmpty ?? false)
    }
    
    public var isNotNilNotEmpty: Bool {
        !isNilorEmpty
    }
}


extension Optional where Wrapped: RangeReplaceableCollection {
    mutating func concat(_ newElements: Wrapped) {
        if self == nil {
            self = newElements
        } else {
            self = self.emptyValueIfNil + newElements
        }
    }
}
