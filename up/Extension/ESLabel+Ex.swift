//
//  ESLabel.swift
//  up
//
//  Created by SINN SOKLYHOR on 26/4/24.
//

import Foundation
import UIKit

extension UILabel {
    
    public func setText(text: String) -> Self {
        self.text = text
        return self
    }
    
    public func setTextColor(color: UIColor) -> Self {
        self.textColor = color
        return self
    }
    
    public func setFont(font: UIFont) -> Self {
        self.font = font
        return self
    }
}
