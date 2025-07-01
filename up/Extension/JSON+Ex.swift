//
//  JSON+Ex.swift
//  up
//
//  Created by Chanon Latt on 14/9/24.
//

import SwiftyJSON

extension Optional where Wrapped == Data {
    
    public func toJSON() -> JSON? {
        if let self {
            return JSON(self)
        }
        return nil
    }
}

extension Data {
    public func toJSON() -> JSON {
        JSON(self)
    }
}
