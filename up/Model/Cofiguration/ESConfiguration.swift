//
//  ESConfiguration.swift
//  up
//
//  Created by Ly Hor Sin on 17/6/24.
//

import Foundation
import ObjectMapper

class ESConfiguration: Mappable {
    
    var google: Google?
    var news: NewsConfig?

    required init?(map: ObjectMapper.Map) {
        
    }
    
    func mapping(map: ObjectMapper.Map) {
        google <- map["google"]
        news <- map["news"]
    }
    
    class func getConfiguration(dict: [String:Any]) -> ESConfiguration {
        return Mapper<ESConfiguration>().map(JSONObject: dict)!
    }
}

// MARK: - Google
class Google: Mappable {
    var clientKey, mapServiceKey, mapPlaceClientKey, youtubeApiKey: String?

    required init?(map: ObjectMapper.Map) {
        
    }
    
    func mapping(map: ObjectMapper.Map) {
        youtubeApiKey <- map["youtube_api_key"]
        clientKey <- map["client_key"]
        mapServiceKey <- map["map_service_key"]
        mapPlaceClientKey <- map["map_place_client_key"]
    }
}

//Mark: - Chat
class NewsConfig: Mappable {
    
    var apiKey: String?
    
    required init(map: ObjectMapper.Map) {
        
    }
    
    func mapping(map: ObjectMapper.Map) {
        apiKey <- map["news_api_key"]
    }
}
