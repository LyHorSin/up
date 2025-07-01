//
//  ESText+Ex.swift
//  up
//
//  Created by Chanon Latt on 7/9/24.
//

import SwiftUI

extension Text {
    init(_ optionalString: String?, defaultValueIfNil: String = "") {
        self.init(verbatim: optionalString ?? defaultValueIfNil)
    }
    
    init(_ number: (any Numeric)?) {
        self.init(number?.toString())
    }
    
    public func textColor(_ color: Color) -> some View {
        self.foregroundColor(color)
    }
}
