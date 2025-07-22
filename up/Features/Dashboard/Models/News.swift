//
//  News.swift
//  up
//
//  Created by Ly Hor Sin on 28/6/25.
//
import ObjectMapper
import Alamofire
import SwiftyJSON

class News: Mappable {
    
    let _id = UUID()
    var id:Int?
    var title:String?
    var description:String?
    var image:String?
    var author:String?
    var authorProfile:String?
    var medias:[String]?
    
    required init?(map: Map) {}
    
    func mapping(map: ObjectMapper.Map) {
        id <- map["id"]
        description <- map["title"]
        image <- map["urlToImage"]
        author <- map["author_name"]
        authorProfile <- map["author_profile"]
        medias <- map["medias"]
    }
    
    class func getNews(response: AFDataResponse<Data>) -> [News] {
        guard let data = response.data else {
            return []
        }

        let news = JSON(data)["data"]["item"].arrayValue.compactMap {
            Mapper<News>().map(JSONObject: $0.dictionaryObject)
        }
        
        return news
    }
}
