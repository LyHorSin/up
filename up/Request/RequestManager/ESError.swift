//
//  ESError.swift
//  up
//
//  Created by Ly Hor Sin on 29/5/24.
//

import Foundation
import ObjectMapper

public let SUCCESS_CODE = 200
public let ERROR_CODE = 400
public let UNAUTHORIZED_CODE = 401

class ESError: Mappable {
    
    var code:Int?
    var success:Bool?
    var title:String?
    var error:String?
    var message:String?
    
    required init?(map: ObjectMapper.Map) {
    }
    
    func mapping(map: ObjectMapper.Map) {
        code <- map["code"]
        success <- map["success"]
        error <- map["errors"]
        title <- map["title"]
        message <- map["error_message"]
    }
    
    class func getError(dict: [String:Any]) -> ESError {
        return Mapper<ESError>().map(JSONObject: dict)!
    }
    
    class func getGeneralError() -> ESError {
        let dict:[String:Any] = [
            "code" : ERROR_CODE,
            "success" : false,
            "errors"   : "An error happen on the mobile application. Try again later and contact the support if you keep meeting this issue.",
            "message" : "Error"
        ]
        return Mapper<ESError>().map(JSONObject: dict)!
    }
    
    class func getNetworkConnectionError() -> ESError {
        let dict:[String:Any] = [
            "code" : ERROR_CODE,
            "success" : false,
            "errors"   : "We are unable to connect to the network at this time. Please verify your network settings and try again.",
            "message" : "No Connection"
        ]
        return Mapper<ESError>().map(JSONObject: dict)!
    }
    
    class func getUnauthorizedError() -> ESError {
        let dict:[String:Any] = [
            "code" : UNAUTHORIZED_CODE,
            "success" : false,
            "errors"   : "Your session has expired. Please log in to continue.",
            "message" : "Unauthenticated"
        ]
        return Mapper<ESError>().map(JSONObject: dict)!
    }
    
    class func getTechnicalError() -> ESError {
        let dict:[String:Any] = [
            "code" : ERROR_CODE,
            "success" : false,
            "errors"   : "Dear customer, we regret to inform you that our system is currently in maintenance mode. We are working hard to restore the system as soon as possible. We apologize for any inconvenience caused and appreciate your patience and understanding.\nThank you for your cooperation.",
            "message" : "System Maintenance"
        ]
        return Mapper<ESError>().map(JSONObject: dict)!
    }
    
    class func getError(error: String) -> ESError {
        let dict:[String:Any] = [
            "code" : ERROR_CODE,
            "success" : false,
            "errors"   : error,
            "message" : "Error"
        ]
        return Mapper<ESError>().map(JSONObject: dict)!
    }
}
