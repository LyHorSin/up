//
//  ESNotificationCenter.swift
//  STC
//
//  Created by Ly Hor Sin on 24/8/23.
//

import Foundation
import UserNotifications
import UIKit

enum STCNotificationType:String {
    case Media
    case RequestDriver = "request_driver"
}

class ESNotificationCenter: NSObject, ObservableObject {
    
    public static let share = ESNotificationCenter()
    
    public var notificationWillPresent:((_ data: [AnyHashable : Any]) ->Void)? = nil
    public var notificationDidReceive:((_ data: [AnyHashable : Any]) ->Void)? = nil
    
    private let center = UNUserNotificationCenter.current()
    
    // Register notification if granted
    public func requestAuthorization(completionHandler: @escaping (Bool) -> Void) {
        center.delegate = self
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            DispatchQueue.main.async {
                if granted {
                    UIApplication.shared.registerForRemoteNotifications()
                }
                completionHandler(granted)
            }
        }
    }
    
    // Request check notification status
    public func getNotificationSettings(completionHandler: @escaping (UNAuthorizationStatus) -> Void) {
        center.getNotificationSettings { setting in
            DispatchQueue.main.async {
                completionHandler(setting.authorizationStatus)
            }
        }
    }
    
    // Get getDeliveredNotifications
    public func getDeliveredNotifications(completionHandler: @escaping ([UNNotification]) -> Void) {
        center.getDeliveredNotifications { notifications in
            DispatchQueue.main.async {
                completionHandler(notifications)
            }
        }
    }
}

extension ESNotificationCenter: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        notificationWillPresent?(userInfo)
        print("userInfo", userInfo)

        if #available(iOS 14.0, *) {
            completionHandler([.list, .sound, .banner])
        } else {
            completionHandler([.sound, .badge])
        }
    }
    
//    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
//        let userInfo = response.notification.request.content.userInfo
//        notificationDidReceive?(userInfo)
//        eventHandler(userInfo: userInfo)
//        print("userInfo", userInfo)
//        completionHandler()
//    }
//    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
            // Check if the app is in background or foreground
            let applicationState = UIApplication.shared.applicationState
            let userInfo = response.notification.request.content.userInfo
            if applicationState == .active  || applicationState == .inactive {
                notificationDidReceive?(userInfo)
                eventHandler(userInfo: userInfo)
                print("userInfo", userInfo)

            } else if applicationState == .background{
                DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                    self.notificationDidReceive?(userInfo)
                    self.eventHandler(userInfo: userInfo)
                    print("userInfo", userInfo)

                }
            }
            completionHandler()
        }
}
