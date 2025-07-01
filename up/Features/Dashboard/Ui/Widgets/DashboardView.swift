//
//  ESOnboardingListView.swift
//  up
//
//  Created by Ly Hor Sin on 29/5/25.
//

import SwiftUI

struct ESOnboardingPagerView: View {
    
    public let items: [ESOnboarding]
    public var onNextTapped: (() -> Void)?   // Add this closure
    @State private var selectedIndex: Int = 0

    var body: some View {
        TabView(selection: $selectedIndex) {
            ForEach(Array(items.enumerated()), id: \.element.id) { index, item in
                ESOnboardingItem(item: item)
                    .tag(index)
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .animation(.easeInOut, value: selectedIndex)
        .overlay(
            ESOnboardingPagerIndicatorView(numberOfpages: items.count,
                                           selectedIndex: $selectedIndex,
                                           onNextTapped: onNextTapped)
        )
        .padding(.vertical, 22)
        .background(Color.black)
        .ignoresSafeArea()
    }
}

struct ESOnboardingPagerIndicatorView: View {
    
    let numberOfpages: Int
    @Binding var selectedIndex:Int
    var onNextTapped: (() -> Void)?   // Add this closure
    
    var body: some View {
        HStack {
            if selectedIndex < numberOfpages - 1 {
                Spacer()
                Spacer()
            } else {
                ESButton(title: "Next")
                    .frame(width: 230.pxh, height: 38.pxh)
                    .padding(.bottom, 22.pxh)
                    .onTapGesture {
                        onNextTapped?()  // Call the closure
                    }
            }
            
        }
        .frame(maxHeight: .infinity, alignment: .bottom)
        .transition(.opacity)
        .animation(.easeInOut, value: selectedIndex)
    }
}
