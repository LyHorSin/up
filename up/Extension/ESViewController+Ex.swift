//
//  ESViewController+Ex.swift
//  up
//
//  Created by SINN SOKLYHOR on 30/4/24.
//

import Foundation
import UIKit
import SwiftUI

extension UIViewController {
    
    public func setUpNavBarTitleStyle() {
        let attributes = [
            NSAttributedString.Key.foregroundColor: UIColor.blackColor,
            NSAttributedString.Key.font: UIFont.mediem(size: 20)
        ]
        
        UINavigationBar.appearance().titleTextAttributes = attributes
    }
    
    public func popToRoot() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    public func goBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    public func popToController<T: UIViewController>(_ aClass: T.Type, goBackIfNeed: Bool = false) {
        var didPop = false
        if let viewControllers = self.navigationController?.viewControllers {
            for viewController in viewControllers.reversed() {
                if viewController is T {
                    didPop = true
                    self.navigationController?.popToViewController(viewController, animated: true)
                    break
                }
            }
        }
        
        if !didPop && goBackIfNeed {
            self.goBack()
        }
    }
    
    public func pushController(destination: UIViewController, animated: Bool = true) {
        destination.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(destination, animated: animated)
    }
    
    public func present(destination: UIViewController, animated: Bool = true) {
        destination.hidesBottomBarWhenPushed = true
        self.present(destination, animated: animated)
    }
    
    public func pushAndReplaceController(destination: UIViewController, animated: Bool = true) {
        destination.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(destination, animated: animated)
        
        if let navigationController = self.navigationController {
            if let lastViewController = navigationController.viewControllers.last {
                navigationController.setViewControllers([lastViewController], animated: animated)
            }
        }
    }
    
    public func replaceRootViewController(with newRootViewController: UIViewController, animated: Bool = true) {
        guard let window = UIApplication.shared.windows.first else {
            print("No window found!")
            return
        }
        
        // If animation is required
        if animated {
            let snapshot = window.snapshotView(afterScreenUpdates: true)
            newRootViewController.view.addSubview(snapshot ?? UIView())
            
            window.rootViewController = newRootViewController
            window.makeKeyAndVisible()
            
            UIView.animate(withDuration: 0.3, animations: {
                snapshot?.alpha = 0
            }, completion: { _ in
                snapshot?.removeFromSuperview()
            })
        } else {
            // Directly set the root view controller without animation
            window.rootViewController = newRootViewController
            window.makeKeyAndVisible()
        }
    }
}
