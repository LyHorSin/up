//
//  ESColor+Ex.swift
//  EShopping
//
//  Created by SINN SOKLYHOR on 25/4/24.
//

import Foundation
import UIKit
import SwiftUI

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}

extension UIColor {
    
    
    public static let whiteColor = UIColor(hexString: "#FFFFFF")
    public static let blackColor = UIColor(hexString: "#070114")
    public static let purpleColor = UIColor(hexString: "#8820E2")
    public static let lightPurpleColor = UIColor(hexString: "#AD83FF")

    public static let darkBlue = UIColor(hexString: "#1C063F")
    public static let blueColor = Color(UIColor(hexString: "#39AEFF"))
    
    // Text Color
    public static let silverChalice = UIColor(hexString: "#B4B2B8")
    public static let greenColor = UIColor(hexString: "#2BB073")

    // Background Color
    public static let lavenderGrey = UIColor(hexString: "#F5F5F7")
    public static let lavenderLightGrey = UIColor(hexString: "#D5D2D9")
    public static let smokeGrey = UIColor(hexString: "#F4F3F7")
    public static let greySteel = UIColor(hexString: "#F1F0F7")
    public static let cloudyGrey = UIColor(hexString: "#D9D9D9")

    //Green
    public static let greenLightColor = UIColor(hexString: "#34A853")
    
    //App Color
    public static let appColor = UIColor(hexString: "#011730")
    public static let meduimBrown = UIColor(hexString: "#C8A144")
    public static let lightBrown = UIColor(hexString: "#B5965E")
    public static let tabBarColor = UIColor(hexString: "#F8F9FA")
    public static let grey = UIColor(hexString: "#6A7179")
    public static let midnightBlue = UIColor(hexString: "#0E2180")

}

extension Color {
    
    public static let primaryColor = Color(UIColor(hexString: "#000000"))
    public static let onPrimaryColor = Color(UIColor(hexString: "#F1F1F1"))
    public static let secondaryColor = Color(UIColor(hexString: "#B5965E"))
    public static let onSecondaryColor = Color(UIColor(hexString: "#28200E"))
    
    public static let whiteColor = Color(UIColor(hexString: "#FFFFFF"))
    public static let white90 = Color(UIColor(hexString: "#F1F0F7"))
    public static let white80 = Color(UIColor(hexString: "#F3F3F3"))
    
    public static let blackColor = Color(UIColor(hexString: "#070114"))
    
    public static let lightPurpleColor = Color(UIColor(hexString: "#AD83FF"))
    public static let darkColor = Color(UIColor(hexString: "#1D1E20"))
    
    public static let darkBlue = Color(UIColor(hexString: "#1C063F"))
    public static let blueColor = Color(UIColor(hexString: "#39AEFF"))
    
    public static let orangeColor = Color(UIColor(hexString: "#F7D739"))

    // Text Color
    public static let silverChalice = Color(UIColor(hexString: "#B4B2B8"))
    public static let greenColor = Color(UIColor(hexString: "#2BB073"))
    
    // Background Color
    public static let lavenderGrey = Color(UIColor(hexString: "#F5F5F7"))
    public static let lavenderLightGrey = Color(UIColor(hexString: "#D5D2D9"))
    public static let lightGrey = Color(UIColor(hexString: "#E8E8E8"))
    public static let pinkColor = Color(UIColor(hexString: "#EE5353"))
    public static let smokeGrey = Color(UIColor(hexString: "#F4F3F7"))
    public static let greySteel = Color(UIColor(hexString: "#F1F0F7"))
    public static let lightLavenderGray = Color(UIColor(hexString: "#F2F0F7"))
    public static let cloudyGrey = Color(UIColor(hexString: "#D9D9D9"))

    //Green
    public static let greenLightColor = Color(UIColor(hexString: "#34A853"))
    //App Color
    public static let appColor = Color(UIColor(hexString: "#011730"))
    public static let meduimBrown = Color(UIColor(hexString: "#C8A144"))
    public static let lightBrown = Color(UIColor(hexString: "#B5965E"))
    public static let tabBarColor = Color(UIColor(hexString: "#F8F9FA"))
    public static let grey = Color(UIColor(hexString: "#6A7179"))
    public static let midnightBlue = Color(UIColor(hexString: "#0E2180"))
    public static let darkgray = Color(UIColor(hexString: "#1A2E45"))
    
}
