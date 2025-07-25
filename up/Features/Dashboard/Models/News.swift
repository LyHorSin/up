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
    var adId:String?
    
    init() {}
    
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

        var news = JSON(data)["data"]["item"].arrayValue.compactMap {
            Mapper<News>().map(JSONObject: $0.dictionaryObject)
        }
        
        let ad = News()
        ad.adId = "1445293286789279_1445293636789244"
        ad.title = "Advertizing"
        ad.author = "Ly Hor Sin"
        ad.medias = [
            "https://picsum.photos/\(screenHeight)/\(screenWidth)",
            "https://picsum.photos/\(screenHeight)/\(screenWidth)",
        ]
        ad.description = "Facebook Audience Network ads help monetize your app by displaying targeted advertisements, such as banners or interstitials, directly within your app interface. Integrating FB ads into each tab or view allows you to generate revenue while maintaining user engagement, but it's important to ensure correct orientation settings and ad formats (like using FBAdView for inline banners) to avoid crashes or full-screen disruptions."
        news.append(ad)
        
        return news
    }
}
