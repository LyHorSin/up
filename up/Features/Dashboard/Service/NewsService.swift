//
//  NewsService.swift
//  up
//
//  Created by Ly Hor Sin on 28/6/25.
//

class NewsService: ESApiRequest {
    
    let page:Int
    
    init(page: Int) {
        self.page = page
    }
    
    override var url: String {
        var url = "\(domain)/\(version.rawValue)/\(suffix)"
        if let params = params, params.isNotEmpty {
            url += "?\(params)"
        }
        return url
    }
    
    override var suffix: String {
        return "top-headlines"
    }
    
    override var version: ESVersion {
        return .v2
    }
    
    override var params: String? {
        let apiKey = ESAppConfiguration.share.configuration?.news?.apiKey
        if let apiKey = apiKey {
            return "apiKey=\(apiKey)&country=us&page=\(page)"
        }
        return "country=us&page=\(page)"
    }
}
