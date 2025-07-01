//
//  News.swift
//  up
//
//  Created by Ly Hor Sin on 28/6/25.
//
import ObjectMapper

class News: Mappable {
    
    let _id = UUID()
    var id:Int?
    var title:String?
    var description:String?
    var images:[String]?
    
    required init?(map: ObjectMapper.Map) {
        
    }
    
    func mapping(map: ObjectMapper.Map) {
        <#code#>
    }
}
