//
//  Main.swift
//  Up
//
//  Created by SINN SOKLYHOR on 24/4/24.
//

import Foundation
import UIKit
import SwiftUI

class Main {
    
    var window:UIWindow?
    
    init(window: UIWindow? = nil) {
        self.window = window
    }
    
    private let appManager = ESAppManager.share
}

extension Main {
    
    public func getRoot() -> UIViewController {
        return DashboardHostingController()
    }
}
