//
//  Collection+Ex.swift
//  up
//
//  Created by Chanon Latt on 7/9/24.
//

import Foundation

extension Collection {
    var isNotEmpty: Bool {
        !isEmpty
    }
    
    var isSingleElement: Bool {
        count == 1
    }
    
    var isMultiElements: Bool {
        count > 1
    }
}
