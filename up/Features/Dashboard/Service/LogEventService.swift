//
//  LogEventService.swift
//  up
//
//  Created by Ly Hor Sin on 28/6/25.
//

import Alamofire

class LogEventService: ESApiRequest {
    
    let id:Int
    
    init(id: Int) {
        self.id = id
    }
    
    override var url: String {
        return "\(domain)/api/\(suffix)"
    }
    
    override var suffix: String {
        return "news/interests"
    }
    
    override var method: HTTPMethod {
        return .post
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
    
    override var body: [String : Any]? {
        return [
            "ids" : [id]
        ]
    }
}
