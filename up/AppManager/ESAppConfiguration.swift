//
//  ESAppConfiguration.swift
//  up
//
//  Created by Ly Hor Sin on 17/6/24.
//

import Foundation
import SwiftyJSON

class ESAppConfiguration {
    
    public static let share = ESAppConfiguration.init()
    
    public var configuration: ESConfiguration?
    
    init() {
        getConfiguration()
    }
    
    private func getConfiguration() {
        do {
           if let bundlePath = Bundle.main.path(forResource: "configuration", ofType: "json"),
              let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
               if let json = JSON(jsonData).dictionaryObject {
                   configuration = ESConfiguration.getConfiguration(dict: json)
               }
           }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    public func initConfiguration() {
        
        // Observe network
        STCNetworkManager.shared.startNetworkMonitoring()
        
        // Set up Notification
        ESNotificationCenter.share.requestAuthorization { grand in }
        
        // Add WebP/SVG/PDF support
        ESCatcheManager.catchInit()
        
        ESLocationManager.share.configProviderAPIKey()
        
        ESChatManager.share.configuration(configuration: configuration)
    }
}
