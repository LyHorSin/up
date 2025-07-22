//
//  NewView.swift
//  up
//
//  Created by Ly Hor Sin on 29/5/25.
//

import SwiftUI

struct NewView: View {
    
    @State private var currentPage = UUID.init()
    @Binding var news: [News]
    
    @EnvironmentObject private var viewModel: DashboardObservable
    
    var body: some View {
        GeometryReader { proxy in
            TabView(selection: $currentPage) {
                ForEach($news, id: \._id) { $news in
                    NewsItemView(news: news,
                                 width: screenWidth,
                                 height: screenHeight)
                }
                .rotationEffect(.degrees(-90))
                .frame(width: proxy.size.width, height: proxy.size.height)
            }
            .frame(width: proxy.size.height, height: proxy.size.width)
            .rotationEffect(.degrees(90), anchor: .topLeading)
            .offset(x: proxy.size.width)

            .onChange(of: currentPage) { newValue in
                if let index = self.news.firstIndex(where: {$0._id == currentPage}) {
                    if Int(index) > self.news.count - 4 {
                        self.viewModel.requestNews()
                    }
                }
            }
            .tabViewStyle(
                PageTabViewStyle(indexDisplayMode: .never)
            )
        }
    }
}
