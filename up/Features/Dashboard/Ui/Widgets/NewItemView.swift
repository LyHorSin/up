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
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView {
                if let images = news.medias, !images.isEmpty {
                    ForEach(images, id: \.self) { image in
                        AnimatedImage(url: URL(string: image)) {
                            ProgressView()
                        }
                        .resizable()
                        .scaledToFit()
                        .clipped()
                    }
                }
            }
            
            ProfileView(name: news.author,
                        description: news.description)
        }
    }
}
