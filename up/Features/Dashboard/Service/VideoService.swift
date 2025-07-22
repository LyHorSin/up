//
//  VideoService.swift
//  up
//
//  Created by Ly Hor Sin on 28/6/25.
//

import Alamofire

class VideoService: ESApiRequest {
    
    let page:Int
    
    init(page: Int) {
        self.page = page
    }
    
    override var url: String {
        return "https://api005.backblazeb2.com/b2api/v2/b2_list_file_names"
    }
    
    override var version: ESVersion {
        return .v2
    }
    
    override var method: HTTPMethod {
        return .post
    }
    
    override var body: [String : Any]? {
        return [
            "bucketId": "5fed09720856d73f9a7c0a17",
            "maxFileCount": 10
        ]
    }
    
    override var headers: [String : String]? {
        return [
            "Authorization" : "4_005fd92867faca70000000000_01bd9705_e06996_acct_u75VNITzt_cHI4e0X9S4ymZpeVo="
        ]
    }
}
