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
    
    private var videoURLs: [URL] = [
        URL(string: "https://vfx.mtime.cn/Video/2019/06/29/mp4/190629004821240734.mp4")!,
        URL(string: "https://vfx.mtime.cn/Video/2019/06/27/mp4/190627231412433967.mp4")!,
        URL(string: "https://vfx.mtime.cn/Video/2019/06/25/mp4/190625091024931282.mp4")!,
        URL(string: "https://vfx.mtime.cn/Video/2019/06/16/mp4/190616155507259516.mp4")!,
        URL(string: "https://vfx.mtime.cn/Video/2019/06/05/mp4/190605101703931259.mp4")!,
    ]
    
    @State private var currentIndex: Int = 0
    @State private var activeIndex: Int = 0
    
    var body: some View {
        ZStack {
            GeometryReader { proxy in
                TabView(selection: $currentIndex) {
                    ForEach(videoURLs.indices, id: \.self) { index in
                        VideoPlayerView(
                            url: videoURLs[index],
                            play: index == activeIndex
                        )
                    }
                    .rotationEffect(.degrees(-90)) // Rotate content
                    .frame(
                        width: proxy.size.width,
                        height: proxy.size.height
                    )
                }
                .onChange(of: currentIndex) { newIndex in
                    activeIndex = newIndex
                }
                .onAppear {
                    activeIndex = currentIndex
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
    let url: URL
    let play: Bool
    
    @State private var time: CMTime = .zero
    @State private var autoReplay: Bool = true
    @State private var mute: Bool = false
    @State private var speedRate: Float = 1.0
    
    var body: some View {
        VideoPlayer(url: url, play: .constant(play), time: $time)
            .autoReplay(autoReplay)
            .mute(mute)
            .speedRate(speedRate)
            .scaledToFit()
            .aspectRatio(contentMode: .fit)
    }
}
