//
//  DashboardObservable.swift
//  up
//
//  Created by Ly Hor Sin on 28/6/25.
//

class DashboardObservable: ObservableObject {
    
    @Published var news: [News] = []
    @Published var page: Int = 0
    @Published var requesting: Bool = false
}

extension DashboardObservable {
    
    public func request() {
        
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
}
