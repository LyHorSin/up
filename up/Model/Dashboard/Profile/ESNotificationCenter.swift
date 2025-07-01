//
//  ESNotification.swift
//  up
//
//  Created by Admin on 5/10/24.
//

import Foundation
import ObjectMapper
import SwiftyJSON

enum NotificationType: String {
    case order
    case promotion
    case chat
}

class ESNotificationCenter: Mappable {
    
    let id = UUID()
    var objectId:String?
    var title:String?
    var image:String?
    var body:String?
    var enable:Bool?
    var languageCode:String?
    var type:NotificationType?
    
    required init?(map: ObjectMapper.Map) {
        
    }
    
    func mapping(map: ObjectMapper.Map) {
        objectId <- map["id"]
        title <- map["title"]
        image <- map["image"]
        body <- map["body"]
        enable <- map["enable"]
        languageCode <- map["language_code"]
        type <- map["notification_type"]

    }
    
    class func getNotification(json: [AnyHashable: Any]) -> ESNotificationCenter? {
        return Mapper<ESNotificationCenter>().map(JSONObject: json)
    }
}
