//
//  ESBaseViewController.swift
//  up
//
//  Created by Ly Hor Sin on 29/5/25.
//

import SwiftUI
import Combine

class ESBaseHostingController<Content: View, VM: ObservableObject>: UIHostingController<AnyView>, ObservableObject {

    // MARK: - ViewModel
    var viewModel: VM?
    var cancellables = Set<AnyCancellable>()

    // MARK: - UI Components
    var navBarView: AnyView?
    var bottomView: AnyView?
    var content: () -> Content

    // Publisher for view updates
    let objectWillChange = ObservableObjectPublisher()

    // MARK: - Initializer
    init(viewModel: VM? = nil,
         navBarView: AnyView? = nil,
         bottomView: AnyView? = nil,
         @ViewBuilder content: @escaping () -> Content) {

        self.viewModel = viewModel
        self.navBarView = navBarView
        self.bottomView = bottomView
        self.content = content

        let composed = VStack(spacing: 0) {
            if let nav = navBarView { nav }
            content()
            if let bottom = bottomView { bottom }
        }

        super.init(rootView: AnyView(composed))
    }

    @MainActor @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        configure()
    }

    // MARK: - Tap to dismiss keyboard
    public func addTapToDismissKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapToDismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }

    @objc private func handleTapToDismissKeyboard() {
        view.endEditing(true)
    }

    // MARK: - Override point
    func configure() {
        // Subclasses can override
    }

    func bindViewModel() {
        viewModel?
            .objectWillChange
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.objectWillChange.send()
            }
            .store(in: &cancellables)
    }
}
