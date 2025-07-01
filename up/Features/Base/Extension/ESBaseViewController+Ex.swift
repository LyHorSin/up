//
//  ESBaseViewController+Ex.swift
//  up
//
//  Created by Ly Hor Sin on 29/5/25.
//

import SwiftUI

extension ESBaseHostingController {
    
    public var safeAreaInsets: UIEdgeInsets {
        return view.safeAreaInsets
    }
}

extension ESBaseHostingController {
    
    public func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                        to: nil, from: nil, for: nil)
    }

    public func setBackgroundColor(_ color: UIColor) {
        self.view.backgroundColor = color
    }
    
    public func overrideUserInterfaceStyle(to style: UIUserInterfaceStyle) {
        overrideUserInterfaceStyle = style
    }
}

extension ESBaseHostingController {
    
    public func push<NextContent: View>(view: NextContent, title: String? = nil) {
        let hosting = UIHostingController(rootView: view)
        hosting.title = title
        self.navigationController?.pushViewController(hosting, animated: true)
    }

    public func pop() {
        self.navigationController?.popViewController(animated: true)
    }
}
