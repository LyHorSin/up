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
    
    @State private var currentPage = UUID.init()
    @State private var activePage = UUID.init()
    
    @EnvironmentObject private var viewModel: DashboardObservable
    
    let url = "https://f005.backblazeb2.com/file/camup-news/download.mp4?Authorization=4_005fd92867faca70000000000_01bd9705_e06996_acct_u75VNITzt_cHI4e0X9S4ymZpeVo="
    
    var body: some View {
        ZStack {
            GeometryReader { proxy in
                TabView(selection: $currentPage) {
                    ForEach($videos, id: \._id) { $video in
                        VideoPlayerView(
                            url: url,
                            play: activePage == video._id
                        )
                    }
                    .rotationEffect(.degrees(-90))
                    .frame(
                        width: proxy.size.width,
                        height: proxy.size.height
                    )
                }
                .onChange(of: currentPage) { newIndex in
                    activePage = newIndex
                }
                .onAppear {
                    activePage = currentPage // resume current video
                }
                .onDisappear {
                    activePage = UUID() // stop video
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
        } else {
            ESText("Loading")
        }
    }
}
