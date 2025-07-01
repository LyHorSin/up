//
//  AppDelegate.swift
//  EShopping
//
//  Created by SINN SOKLYHOR on 24/4/24.
//

import UIKit
import FBSDKCoreKit
import Firebase
import FirebaseCrashlytics

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    public let firebaseManager = ESFirebaseManager.share
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Firebase Configuration
        firebaseManager.appConfiguration()
        
        Thread.sleep(forTimeInterval: 1.5)
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        
        return true
    }

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return ApplicationDelegate.shared.application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
    }

    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        firebaseManager.saveFCMToken(deviceToken: deviceToken)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {

    }
    
    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        // Check if the URL scheme matches
        if url.scheme == "upmobileapp" || url.scheme == "upsellerapp" {
            // Handle the custom URL
            print("Received custom URL: \(url)")
            // Perform action based on the URL (e.g., navigate to a specific view)
            return true
        }
        return false
    }
}

