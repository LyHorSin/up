//
//  ESTokens.swift
//  up
//
//  Created by Reaksmey Ruon on 16/9/24.
//

import Foundation
import ObjectMapper
import SwiftUI

struct ESTokens {
    
    let id = UUID()
    var percent:String
    var date:String?
    var condition:String?
    var color:Color?
    
    init(percent: String, date:String? = nil, condition: String? = nil, color: Color? = nil) {
        self.percent = percent
        self.date = date
        self.condition = condition
        self.color = color
    }
    
    public static let tokens:[ESTokens] = [
        .init(percent: "20% OFF", date: "01/28/2024 ~01/28/2024", condition: "Purchase over $100", color: Color.purpleColor),
        .init(percent: "20% OFF", date: "01/28/2024 ~01/28/2024", condition: "Purchase over $100", color: Color.greenColor),
        .init(percent: "20% OFF", date: "01/28/2024 ~01/28/2024", condition: "Purchase over $100", color: Color.blueColor),
        .init(percent: "20% OFF", date: "01/28/2024 ~01/28/2024", condition: "Purchase over $100", color: Color.lightPurpleColor)

    ]

}
