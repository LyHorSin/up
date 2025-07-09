//
//  VideoService.swift
//  up
//
//  Created by Ly Hor Sin on 28/6/25.
//

class VideoService: ESApiRequest {
    
    let page:Int
    
    init(page: Int) {
        self.page = page
    }
    
    override var url: String {
        var url = "\(domain)/\(suffix)"
        if let params = params, params.isNotEmpty {
            url += "?\(params)"
        }
        return url
    }
    
    override var domain: String {
        return "https://api.pexels.com"
    }
    
    override var suffix: String {
        return "videos/popular"
    }
    
    override var params: String? {
        return "page=\(page)"
    }
    
    override var headers: [String : String]? {
        let apiKey = ESAppConfiguration.share.configuration?.google?.youtubeApiKey
        if let apiKey = apiKey {
            return [
                "Authorization" : apiKey
            ]
        }
        return nil
    }
}
