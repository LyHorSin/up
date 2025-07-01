//
//  ESOnboardingHostingController.swift
//  up
//
//  Created by Ly Hor Sin on 29/5/25.
//

import SwiftUI

class ESOnboardingHostingController: ESBaseHostingController<ESOnboardingPagerView, ESOnboardingObservable> {
    
    init() {
        let viewModel = ESOnboardingObservable()
        super.init(viewModel: viewModel, navBarView: nil, bottomView: nil) {
            ESOnboardingPagerView(items: viewModel.onboarding) {
                
            }
        }
        
        self.overrideUserInterfaceStyle = .dark
    }
    
    @MainActor @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ESOnboardingHostingController {
    
}
