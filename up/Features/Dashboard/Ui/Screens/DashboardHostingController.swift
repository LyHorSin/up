//
//  DashboardHostingController.swift
//  up
//
//  Created by Ly Hor Sin on 29/5/25.
//

import SwiftUI
import AVFAudio

class DashboardHostingController: ESBaseHostingController<DashboardView, DashboardObservable> {
    
    init() {
        let viewModel = DashboardObservable()
        viewModel.requestNews()
        viewModel.requestVideo()
        super.init(viewModel: viewModel, navBarView: nil, bottomView: nil) {
            DashboardView(viewModel: viewModel)
        }
        
        self.overrideUserInterfaceStyle = .dark
    }
    
    @MainActor @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .moviePlayback, options: [])
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to set audio session: \(error)")
        }
    }
}
