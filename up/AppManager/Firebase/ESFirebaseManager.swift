//
//  ESFirebaseManager.swift
//  up
//
//  Created by Ly Hor Sin on 4/11/24.
//

import Foundation
import FirebaseMessaging
import Firebase
import FirebaseCrashlytics

class ESFirebaseManager {
    
    public static let share = ESFirebaseManager()

    public func appConfiguration() {
        
        if ESAppManager.share.target == .Client {
            guard let path = Bundle.main.path(forResource: "up", ofType: "plist") else {
                print("up plist not found")
                return
            }
            if let upOptions = FirebaseOptions(contentsOfFile: path) {
                FirebaseApp.configure(options: upOptions)
            }
        } else {
            guard let path = Bundle.main.path(forResource: "up-Seller", ofType: "plist") else {
                print("up-Seller plist not found")
                return
            }
            if let sellerOptions = FirebaseOptions(contentsOfFile: path) {
                FirebaseApp.configure(options: sellerOptions) // Configure additional app with a name
            }
        }
        
        Crashlytics.crashlytics().setCrashlyticsCollectionEnabled(true)
        Crashlytics.crashlytics().log("Force crash to test Crashlytics during configuration.")
    }

    
    public func saveFCMToken(deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
        Messaging.messaging().token { fcmToken, error in
            
        }
    }
}
