//
//  SceneDelegate.swift
//  EShopping
//
//  Created by SINN SOKLYHOR on 24/4/24.
//

import UIKit
import FBSDKCoreKit
import SwiftUI

var remember:UIViewController? 

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    enum NSUserActivityType: String {
        case Product = "product"
        case Store = "store"
        case Promotion = "promotion"
    }

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        
        let root = Main(window: window)
        window?.rootViewController = root.getRoot()
        window?.makeKeyAndVisible()
        
        //Used for background deeplink
        if let urlContext = connectionOptions.urlContexts.first {
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                self.handleDeepLink(url: urlContext.url)
            }
        }
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let url = URLContexts.first?.url else { return }
        
        // FACE BOOK HANDLE DEEPLINK
        ApplicationDelegate.shared.application(
            UIApplication.shared,
            open: url,
            sourceApplication: nil,
            annotation: [UIApplication.OpenURLOptionsKey.sourceApplication])
        
        // APP HANDLE DEEPLINK
        if url.scheme == "upmobileapp" || url.scheme == "upsellerapp" {
            handleDeepLink(url: url)
        }
    }
    
    func scene(_ scene: UIScene, continue userActivity: NSUserActivity) {
        guard userActivity.activityType == NSUserActivityTypeBrowsingWeb,
              let url = userActivity.webpageURL else {
            return
        }
        
        handleDeepLink(url: url)
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        let active = NotificationCenterPostName.AppBecomeActive.rawValue
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: active), object: nil, userInfo: nil)
    }
}

extension SceneDelegate {
    
    public func handleDeepLink(url: URL) {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
              let queryItems = components.queryItems else {
            return
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            let type = queryItems.first(where: { $0.name == "type" })?.value
            let productId = queryItems.first(where: { $0.name == "productId" })?.value
            let storeId = queryItems.first(where: { $0.name == "storeId" })?.value

            if let presenting = UIApplication.topViewController() {
                if let type = type, let activity = NSUserActivityType(rawValue: type) {
                    print(activity)
                }
            }
        }
    }
}
