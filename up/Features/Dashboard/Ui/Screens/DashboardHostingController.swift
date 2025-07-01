//
//  DashboardHostingController.swift
//  up
//
//  Created by Ly Hor Sin on 29/5/25.
//

import SwiftUI

class DashboardHostingController: ESBaseHostingController<DashboardView, DashboardObservable> {
    
    init() {
        let viewModel = DashboardObservable()
        viewModel.request()
        super.init(viewModel: viewModel, navBarView: nil, bottomView: nil) {
            DashboardView(viewModel: viewModel)
        }
        
        self.overrideUserInterfaceStyle = .dark
    }
    
    @MainActor @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
