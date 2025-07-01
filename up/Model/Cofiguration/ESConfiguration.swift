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
    var chat: Chat?

    required init?(map: ObjectMapper.Map) {
        
    }
    
    func mapping(map: ObjectMapper.Map) {
        google <- map["google"]
        chat <- map["chat"]
    }
    
    class func getConfiguration(dict: [String:Any]) -> ESConfiguration {
        return Mapper<ESConfiguration>().map(JSONObject: dict)!
    }
}

// MARK: - Google
class Google: Mappable {
    var clientKey, mapServiceKey, mapPlaceClientKey: String?

    required init?(map: ObjectMapper.Map) {
        
    }
    
    func mapping(map: ObjectMapper.Map) {
        clientKey <- map["client_key"]
        mapServiceKey <- map["map_service_key"]
        mapPlaceClientKey <- map["map_place_client_key"]
    }
}

//Mark: - Chat
class Chat: Mappable {
    
    var crispDevelopmentKey, crispProductionKey: String?
    
    required init(map: ObjectMapper.Map) {
        
    }
    
    func mapping(map: ObjectMapper.Map) {
        crispDevelopmentKey <- map["crisp_development_key"]
        crispProductionKey <- map["crisp_production_key"]
    }
}
