//
//  ESAppManager.swift
//  EShopping
//
//  Created by SINN SOKLYHOR on 24/4/24.
//

import Foundation

var isClientApp: Bool {
    ESAppManager.share.target == .Client
}

var isSellerApp: Bool {
    ESAppManager.share.target == .Seller
}

enum AppTarget: String {
    case Client = "com.ecommerce.up"
    case Seller = "com.ecommerce.upseller"
}

extension AppTarget {
    public var loadingScreenText: String {
        switch self {
        case .Client:
            return "Welcome to AMS"
            
        case .Seller:
            return "Sell and grow together with up"
        }
    }
}

class ESAppManager: ObservableObject {
    
    public static let share = ESAppManager()
    
    public let environment:ESAppEnvironment = .UAT
    
    @Published var target:AppTarget?
    
    init() {
        checkAppTarget()
        generalConfiguration()
    }
    
    public func checkAppTarget() {
        guard let bundle = Bundle.main.bundleIdentifier else { return }
        if let target = AppTarget(rawValue: bundle) {
            self.target = target
        }
    }
    
    public func generalConfiguration() {
        ESAppConfiguration.share.initConfiguration()
    }
}

extension ESAppManager {
    
    public var appVersion: String {
        let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
        return version ?? "1.0.0"
    }
    
    public var appBuildNumber: String {
        let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String
        return version ?? "1"
    }
}
