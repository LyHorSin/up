//
//  VideoView.swift
//  up
//
//  Created by Ly Hor Sin on 29/5/25.
//

import SwiftUI
import AVFoundation
import SwiftUI
import VideoPlayer

struct VideoView: View {
    
    @Binding var videos: [Video]
    
    @EnvironmentObject private var viewModel: DashboardObservable
    
    var body: some View {
        ZStack {
            GeometryReader { proxy in
                TabView(selection: $viewModel.currentPageOfVideo) {
                    ForEach($videos, id: \._id) { $video in
                        VideoPlayerView(
                            url: video.getUrl,
                            play: viewModel.activePageOfVideo == video._id
                            
                        )
                        .onAppear {
                            if let currentIndex = videos.firstIndex(where: { $0._id == video._id }) {
                                let startIndex = currentIndex + 1
                                let endIndex = min(currentIndex + 5, videos.count - 1)
                                
                                if startIndex <= endIndex {  
                                    let preloadRange = startIndex...endIndex
                                    for index in preloadRange {
                                        let nextVideo = videos[index]
                                        if let url = nextVideo.getUrl?.toUrl() {
                                            viewModel.preloadVideo(url: url)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .rotationEffect(.degrees(-90))
                    .frame(
                        width: proxy.size.width,
                        height: proxy.size.height
                    )
                }
                .onChange(of: viewModel.currentPageOfVideo) { newIndex in
                    viewModel.activePageOfVideo = newIndex
                }
                .onAppear {
                    viewModel.activePageOfVideo = viewModel.currentPageOfVideo // resume current video
                }
                .onDisappear {
                    viewModel.activePageOfVideo = UUID() // stop video
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
}


struct VideoPlayerView: View {
    let url: String?
    let play: Bool
    
    @State private var time: CMTime = .zero
    @State private var autoReplay: Bool = true
    @State private var mute: Bool = false
    @State private var speedRate: Float = 1.0
    
    var body: some View {
        if let url = url, let url = URL(string: url) {
            VideoPlayer(url: url, play: .constant(play), time: $time)
                .autoReplay(autoReplay)
                .mute(mute)
                .speedRate(speedRate)
                .contentMode(.scaleAspectFit)
                .ignoresSafeArea()
        } else {
            ESText("Loading")
        }
    }
}
