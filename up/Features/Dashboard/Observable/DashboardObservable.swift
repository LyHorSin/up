//
//  DashboardObservable.swift
//  up
//
//  Created by Ly Hor Sin on 28/6/25.
//

class DashboardObservable: ObservableObject {
    
    @Published var news: [News] = []
    @Published var videos: [Video] = []
    
    @Published var page: Int = 0
    @Published var requesting: Bool = false
    
    @Published var videoPage: Int = 0
    @Published var requestingVideo: Bool = false
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
            self.videos += Video.getVideos(response: response)
            self.requestingVideo = false
        } errorCompletion: { error in
            if self.videoPage > 0 {
                self.videoPage -= 1
            }
            self.requestingVideo = false
        }
    }
}
