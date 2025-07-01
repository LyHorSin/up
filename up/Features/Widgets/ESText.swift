//
//  ESText.swift
//  up
//
//  Created by Ly Hor Sin on 29/5/25.
//

import SwiftUI

enum ESTextStyle {
    case h1, h2, h3, h4, h5, h6, body, p

    var size: CGFloat {
        switch self {
        case .h1: return scaledFontSize(34)
        case .h2: return scaledFontSize(28)
        case .h3: return scaledFontSize(24)
        case .h4: return scaledFontSize(20)
        case .h5: return scaledFontSize(18)
        case .h6: return scaledFontSize(16)
        case .body: return scaledFontSize(14)
        case .p: return scaledFontSize(12)
        }
    }

    var fontName: String {
        switch self {
        case .h1, .h2:
            return "Poppins-Bold"
        case .h3, .h4:
            return "Poppins-SemiBold"
        case .h5:
            return "Poppins-Medium"
        case .h6:
            return "Poppins-Regular"
        case .body, .p:
            return "Poppins-Light"
        }
    }

    private func scaledFontSize(_ baseSize: CGFloat) -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        return baseSize * (screenWidth / 375) // 375 is base screen width (iPhone 11/12/13)
    }
}

struct ESText: View {
    let text: String
    let style: ESTextStyle
    let color: Color

    init(_ text: String, style: ESTextStyle = .body, color: Color = .primary) {
        self.text = text
        self.style = style
        self.color = color
    }

    var body: some View {
        Text(text)
            .font(.custom(style.fontName, size: style.size))
            .foregroundColor(color)
    }
}
