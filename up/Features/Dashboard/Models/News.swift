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
    
    required init?(map: Map) {}
    
    func mapping(map: ObjectMapper.Map) {
        id <- map["id"]
        title <- map["title"]
        description <- map["content"]
        image <- map["urlToImage"]
        author <- map["author"]
    }
    
    class func getNews(response: AFDataResponse<Data>) -> [News] {
        guard let data = response.data else {
            return []
        }

        let news = JSON(data)["articles"].arrayValue.compactMap {
            Mapper<News>().map(JSONObject: $0.dictionaryObject)
        }
        
        return news
    }
}
