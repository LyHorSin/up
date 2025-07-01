//
//  ESOnboardingItem.swift
//  up
//
//  Created by Ly Hor Sin on 29/5/25.
//

import SwiftUI

struct ESOnboardingItem: View {
    
    let item: ESOnboarding
    
    var body: some View {
        VStack {
            
            ESText(item.title, style: .h3, color: .white)
                .multilineTextAlignment(.center)
            
            ESSizedBox(height: 145.pxh)
            
            Image(item.image)
                .resizable()
                .scaledToFit()
                .frame(width: 162.pxw, height: 150.pxh)
            
            ESSizedBox(height: 52.pxh)
            
            ESText(item.description, style: .body, color: .white)
                .multilineTextAlignment(.center)
        }
        .padding(.horizontal, 24)
    }
}
