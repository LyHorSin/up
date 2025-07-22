//
//  News.swift
//  up
//
//  Created by Ly Hor Sin on 28/6/25.
//
import ObjectMapper
import Alamofire
import SwiftyJSON

class Video: Mappable {
    
    let _id = UUID()
    var fileName:String?

    required init?(map: Map) {}
    
    func mapping(map: ObjectMapper.Map) {
        fileName <- map["fileName"]
    }
    
    class func getVideos(response: AFDataResponse<Data>) -> [Video] {
        guard let data = response.data else {
            return []
        }

        let videos = JSON(data)["files"].arrayValue.compactMap {
            Mapper<Video>().map(JSONObject: $0.dictionaryObject)
        }
        
        return videos
    }
}

extension Video {
    
    public var getUrl: String? {
        return "https://f005.backblazeb2.com/file/camup-news/\(fileName ?? "")?Authorization=4_005fd92867faca70000000000_01bd9705_e06996_acct_u75VNITzt_cHI4e0X9S4ymZpeVo="
    }
}

class VideoFile: Mappable {
    var id: Int?
    var quality: String?
    var fileType: String?
    var width: Int?
    var height: Int?
    var fps: Int?
    var link: String?
    var size: Int?

    required init?(map: Map) {}

    func mapping(map: Map) {
        id       <- map["id"]
        quality  <- map["quality"]
        fileType <- map["file_type"]
        width    <- map["width"]
        height   <- map["height"]
        fps      <- map["fps"]
        link     <- map["link"]
        size     <- map["size"]
    }
}
