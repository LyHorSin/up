//
//  ESNetworkManager.swift
//  EShopping
//
//  Created by SINN SOKLYHOR on 24/4/24.
//

import Foundation
import Alamofire
import SwiftUI
import Combine

enum ReachabilityStatus {
    case noConnection
    case connecting
    case connected
}

enum NotificationCenterPostName: String {
    case RestoredConnection
    case AppBecomeActive
}

class ESViewModel: NSObject, ObservableObject {
    
    public var cancellables = Set<AnyCancellable>()
    private var publisherNotifications: [NotificationCenterPostName: Notification.Name] = [:]
}



extension ESViewModel {
    
    public func post(data: [AnyHashable : Any]? = nil, name: NotificationCenterPostName) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: name.rawValue), object: nil, userInfo: data)
    }
    
    public func postObserve(name: NotificationCenterPostName, completation: @escaping ((_ data: [AnyHashable : Any]?)->Void)) {
        if publisherNotifications[name] == nil {
            let notifyName = Notification.Name(rawValue: name.rawValue)
            NotificationCenter.default.publisher(for: notifyName)
                .sink { notification in
                    DispatchQueue.main.async {
                        let userInfo = notification.userInfo
                        completation(userInfo)
                    }
                }
                .store(in: &cancellables)
            
            publisherNotifications[name] = notifyName
        }
    }
}


class STCNetworkManager: ESViewModel {
    
    public static let shared = STCNetworkManager()
    
    @Published var reachabilityStatus: ReachabilityStatus = .connected
    @Published var reachable:Bool = true
    @Published var presenting: Bool = false
    
    public func startNetworkMonitoring() {
        
        let networkReachabilityManager = NetworkReachabilityManager()
        networkReachabilityManager?.startListening(onUpdatePerforming: { status in
            let status = status == .reachable(.cellular) || status == .reachable(.ethernetOrWiFi)
            withAnimation {
                self.handleReachabilityChange(isReachable: status)
                self.reachable = status
                self.reachabilityStatus = status == true ? .connected : .noConnection
            }
        })
    }
    
    private func handleReachabilityChange(isReachable: Bool) {
        if !presenting && !isReachable {
            withAnimation {
                presenting = true
            }
        }
    }
}
