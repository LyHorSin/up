//
//  DashboardView.swift
//  up
//
//  Created by Ly Hor Sin on 29/5/25.
//
import SwiftUI

struct DashboardView: View {
    
    @StateObject var viewModel: DashboardObservable
    
    @State private var selectedTab = 0
    
    var body: some View {
        ZStack(alignment: .top) {
            // TabView with swipe gesture
            TabView(selection: $selectedTab) {
                NewView(news: $viewModel.news)
                    .tag(0)

                VideoView(videos: $viewModel.videos)
                    .tag(1)
            }
            .environmentObject(viewModel)
            .ignoresSafeArea()
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never)) // No page dots
            .statusBarHidden()
            // Tab labels at the top
            HStack {
                Text("News")
                    .fontWeight(selectedTab == 0 ? .bold : .regular)
                    .foregroundColor(selectedTab == 0 ? .white : .gray)
                    .onTapGesture { selectedTab = 0 }

                SizedBox(width: 12, height: 12)

                Text("Video")
                    .fontWeight(selectedTab == 1 ? .bold : .regular)
                    .foregroundColor(selectedTab == 1 ? .white : .gray)
                    .onTapGesture { selectedTab = 1 }
            }
        }
    }
}
