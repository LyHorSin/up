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
        var url = "\(domain)/api/\(suffix)"
        if let params = params, params.isNotEmpty {
            url += "?\(params)"
        }
        return url
    }
    
    override var suffix: String {
        return "news"
    }
    
    override var headers: [String : String]? {
        let deviceId = UIDevice.current.identifierForVendor?.uuidString
        if let deviceId = deviceId {
            return [
                "Device-ID" : deviceId
            ]
        }
        return nil
    }
}
