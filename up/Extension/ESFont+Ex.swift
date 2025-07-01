//
//  ESFont+Ex.swift
//  EShopping
//
//  Created by SINN SOKLYHOR on 25/4/24.
//

import Foundation
import UIKit
import SwiftUI

extension UIFont {
    
    public static func bold(size: CGFloat) -> UIFont {
        return UIFont(name: "Poppins-Bold", size: size.dynamicFontSize())!
    }
    
    public static func semiBold(size: CGFloat) -> UIFont {
        return UIFont(name: "Poppins-SemiBold", size: size.dynamicFontSize())!
    }
    
    public static func mediem(size: CGFloat) -> UIFont {
        return UIFont(name: "Poppins-Medium", size: size.dynamicFontSize())!
    }
    
    public static func regular(size: CGFloat) -> UIFont {
        return UIFont(name: "Poppins-Regular", size: size.dynamicFontSize())!
    }
    
    public static func camptonSemiBold(size: CGFloat) -> UIFont {
        return UIFont(name: "Campton-SemiBold", size: size.dynamicFontSize())!
    }
    
    public static func camptonBook(size: CGFloat) -> UIFont {
        return UIFont(name: "CamptonBook", size: size.dynamicFontSize())!
    }
    
    public static func light(size: CGFloat) -> UIFont {
        return UIFont(name: "Poppins-Light", size: size.dynamicFontSize())!
    }
    
}

extension Font {
    
    public static func bold(size: CGFloat) -> Font {
        return Font(UIFont(name: "Poppins-Bold", size: size.dynamicFontSize())!)
    }
    
    public static func semiBold(size: CGFloat) -> Font {
        return Font(UIFont(name: "Poppins-SemiBold", size: size.dynamicFontSize())!)
    }
    
    public static func medium(size: CGFloat) -> Font {
        return Font(UIFont(name: "Poppins-Medium", size: size.dynamicFontSize())!)
    }
    
    public static func regular(size: CGFloat) -> Font {
        return Font(UIFont(name: "Poppins-Regular", size: size.dynamicFontSize())!)
    }
    
    public static func camptonSemiBold(size: CGFloat) -> Font {
        return Font(UIFont(name: "Campton-SemiBold", size: size.dynamicFontSize())!)
    }
    
    public static func camptonBook(size: CGFloat) -> Font {
        return Font(UIFont(name: "Campton-Book", size: size.dynamicFontSize())!)
    }
    
    public static func light(size: CGFloat) -> Font {
        return Font(UIFont(name: "Poppins-Light", size: size.dynamicFontSize())!)
    }
}

extension CGFloat {

    public func dynamicFontSize() -> CGFloat {
        let baseScreenWidth: CGFloat = 428.0
        let scalingFactor = screenWidth / baseScreenWidth
        return self * scalingFactor
    }
}
