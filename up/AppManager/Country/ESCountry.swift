//
//  ESCountry.swift
//  up
//
//  Created by SINN SOKLYHOR on 28/4/24.
//

import Foundation
import ObjectMapper

class ESCountry: Mappable {
    
    let id = UUID()
    var name, phoneCode, countryCode: String?
    
    required init?(map: ObjectMapper.Map) {
        
    }
    
    func mapping(map: ObjectMapper.Map) {
        self.name <- map["name"]
        self.phoneCode <- map["dial_code"]
        self.countryCode <- map["code"]
    }
    
    class func getCountry(dict: [String:Any]) -> ESCountry {
        let country = Mapper<ESCountry>().map(JSONObject: dict)
        return country!
    }
}

extension ESCountry {
    
    public var emoji:String {
        let base : UInt32 = 127397
        let code = countryCode ?? ""
        var s = ""
        for v in code.uppercased().unicodeScalars{
            if let value = UnicodeScalar(base + v.value) {
                s.unicodeScalars.append(value)
            }
        }
        return s
    }
}
