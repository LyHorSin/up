//
//  STCNotificationEventHandler.swift
//  STC
//
//  Created by Ly Hor Sin on 13/12/23.
//

import Foundation
import SwiftUI

class STCNotificationEvenObservable: ObservableObject {
    
    public static let share = STCNotificationEvenObservable()
    
    // Media
    @Published var mediaId:Int?
    @Published var visisblePressReleased:Bool = false
    @Published var visisbleGallery:Bool = false
    @Published var visisbleVideoPromote:Bool = false
    @Published var visisbleBruchure:Bool = false
    @Published var visisbleNewsletter:Bool = false
    
}

extension ESNotificationCenter {
    
    public func eventHandler(userInfo: [AnyHashable : Any]) {
        guard let presenting = UIApplication.topViewController() else {
            return
        }

        print(presenting)
    }
}
