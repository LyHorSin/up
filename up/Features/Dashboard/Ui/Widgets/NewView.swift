//
//  NewView.swift
//  up
//
//  Created by Ly Hor Sin on 29/5/25.
//

import SwiftUI

import SwiftUI

struct NewView: View {
    
    @State private var currentPage = UUID.init()
    @Binding var news: [News]
    
    @EnvironmentObject private var viewModel: DashboardObservable
    
    var body: some View {
        ZStack {
            GeometryReader { proxy in
                TabView(selection: $currentPage) {
                    ForEach($news, id: \._id) { $news in
                        AnimatedImage(url: URL(string: news.image ?? "")) {
                            ProgressView()
                        }
                        .resizable()
                        .scaledToFit()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: proxy.size.width)
                        .frame(height: screenHeight)
                        .clipped()
                        .overlay(ProfileView(name: news.author,
                                             description: news.description),
                                 alignment: .bottomLeading)
                    }
                    .rotationEffect(.degrees(-90)) // Rotate content
                    .frame(
                        width: proxy.size.width,
                        height: proxy.size.height
                    )
                }
                .onChange(of: currentPage) { newValue in
                    if let index = self.news.firstIndex(where: {$0._id == currentPage}) {
                        if Int(index) > self.news.count - 4 {
                            self.viewModel.request()
                        }
                    }
                }
                .frame(
                    width: proxy.size.height, // Height & width swap
                    height: proxy.size.width
                )
                .rotationEffect(.degrees(90), anchor: .topLeading) // Rotate TabView
                .offset(x: proxy.size.width) // Offset back into screens bounds
                .tabViewStyle(
                    PageTabViewStyle(indexDisplayMode: .never)
                )
            }
        }
        .statusBar(hidden: true)
        .ignoresSafeArea()
    }
    
    var newsView: some View {
        Image("news_1")
            .resizable()
            .scaledToFill()
            .clipped()
    }
}


