//
//  ESTableView+Ex.swift
//  up
//
//  Created by SINN SOKLYHOR on 30/4/24.
//

import Foundation
import UIKit

extension UITableView {
    
    public func defaultStyle() {
        self.isPagingEnabled = false
        self.separatorStyle = .none
        self.separatorColor = .clear
        self.backgroundColor = .clear
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
    }
}

extension UIScrollView {
    
    public func isEnd(offsetY: CGFloat) -> Bool {
        let contentHeight = self.contentSize.height
        let screenHeight = self.frame.size.height
        
        if offsetY > contentHeight - screenHeight {
            return true
        }
        return false
    }
}
