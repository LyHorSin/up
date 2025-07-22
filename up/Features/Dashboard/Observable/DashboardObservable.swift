//
//  DashboardObservable.swift
//  up
//
//  Created by Ly Hor Sin on 28/6/25.
//

import AVFoundation

class DashboardObservable: ObservableObject {
    
    @Published var news: [News] = []
    @Published var videos: [Video] = []
    
    // Store AVPlayer instances if you wish
    private var preloadedPlayers: [URL: AVPlayer] = [:]
    
    @Published var currentPageOfVideo = UUID.init()
    @Published var activePageOfVideo:UUID? = nil
    
    @Published var page: Int = 0
    @Published var requesting: Bool = false
    
    @Published var videoPage: Int = 0
    @Published var requestingVideo: Bool = false
}

extension DashboardObservable {
    
    public func preloadVideo(url: URL) {
        guard preloadedPlayers[url] == nil else { return }  // Skip if already preloaded
        let playerItem = AVPlayerItem(url: url)
        let player = AVPlayer(playerItem: playerItem)
        preloadedPlayers[url] = player
    }
    
    public func playerForPreloadedVideo(url: URL) -> AVPlayer? {
        return preloadedPlayers[url]
    }
}

extension DashboardObservable {
    
    public func requestNews() {
        
        if requesting {
            return
        }
        
        page += 1
        requesting = true
        ESRequest.request(api: NewsService(page: page)) { response in
            self.news += News.getNews(response: response)
            self.requesting = false
        } errorCompletion: { error in
            if self.page > 0 {
                self.page -= 1
            }
            self.requesting = false
        }
    }
    
    public func requestVideo() {
        
        if requestingVideo {
            return
        }
        
        videoPage += 1
        requestingVideo = true
        ESRequest.request(api: VideoService(page: videoPage)) { response in
            let videos = Video.getVideos(response: response)
            if self.activePageOfVideo == nil, let id = videos.first?._id {
                self.activePageOfVideo = id
                self.currentPageOfVideo = id
            }
            self.videos += videos
            self.requestingVideo = false
        } errorCompletion: { error in
            if self.videoPage > 0 {
                self.videoPage -= 1
            }
            self.requestingVideo = false
        }
    }
}
