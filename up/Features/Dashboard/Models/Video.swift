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
    var id: Int?
    var user: [String: Any]?
    var videoFiles: [VideoFile] = []

    required init?(map: Map) {}
    
    func mapping(map: ObjectMapper.Map) {
        id         <- map["id"]
        user       <- map["user"]
        videoFiles <- map["video_files"]
    }
    
    class func getVideos(response: AFDataResponse<Data>) -> [Video] {
        guard let data = response.data else {
            return []
        }

        let videos = JSON(data)["videos"].arrayValue.compactMap {
            Mapper<Video>().map(JSONObject: $0.dictionaryObject)
        }
        
        return videos
    }
    
    enum InternetSpeed {
        case slow
        case medium
        case fast
    }

    public func getBestVideoFile(from video: Video, speed: InternetSpeed) -> VideoFile? {
        guard !video.videoFiles.isEmpty else { return nil }

        let screenWidth = Int(UIScreen.main.bounds.width * UIScreen.main.scale)
        let screenHeight = Int(UIScreen.main.bounds.height * UIScreen.main.scale)

        let sortedFiles = video.videoFiles.sorted {
            ($0.width ?? 0) * ($0.height ?? 0) > ($1.width ?? 0) * ($1.height ?? 0)
        }

        switch speed {
        case .fast:
            // Return highest resolution ≤ screen size
            return sortedFiles.first(where: {
                ($0.width ?? 0) <= screenWidth && ($0.height ?? 0) <= screenHeight
            }) ?? sortedFiles.first

        case .medium:
            // Return medium-resolution video (e.g., width around 720)
            return sortedFiles.first(where: {
                ($0.width ?? 0) <= 720
            }) ?? sortedFiles.last

        case .slow:
            // Return lowest-resolution video
            return sortedFiles.last
        }
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
