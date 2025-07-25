//
//  NewView.swift
//  up
//
//  Created by Ly Hor Sin on 29/5/25.
//

import SwiftUI

struct NewsItemView: View {
    
    let news: News
    let width: CGFloat
    let height:CGFloat
    
    @State private var currentPage = 0
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $currentPage) {
                if let images = news.medias, !images.isEmpty {
                    ForEach(0..<images.count, id: \.self) { index in
                        let image = images[index]
                        AnimatedImage(url: URL(string: image)) {
                            ProgressView()
                        }
                        .resizable()
                        .scaledToFit()
                        .clipped()
                    }
                }
            }
            .onChange(of: currentPage) { newValue in
                currentPage = newValue
            }
            
            VStack {
                HStack(spacing: 8) {
                    ForEach(0..<(news.medias?.count ?? 0), id: \.self) { index in
                        Circle()
                            .fill(index == currentPage ? Color.gray.opacity(0.5) : Color.black90)
                            .frame(width: 8, height: 8)
                    }
                }
                .padding(.top, 16)
                
                ProfileView(news: news)
            }
        }
    }
}
