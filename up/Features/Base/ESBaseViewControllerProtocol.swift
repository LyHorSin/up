//
//  ESBaseViewControllerProtocol.swift
//  up
//
//  Created by Ly Hor Sin on 29/5/25.
//

protocol ESBaseHostingControllerProtocol: AnyObject {
    associatedtype ViewModel
    var viewModel: ViewModel? { get set }
}

