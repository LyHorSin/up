//
//  ESApiRequest.swift
//  up
//
//  Created by Ly Hor Sin on 29/5/24.
//

import Foundation
import Alamofire

enum ESAppEnvironment: String {
    case Development
    case UAT
    case Production
    
    public var domain:String {
        switch self {
        case .Development: return "https://newsapi.org"
        case .UAT: return "https://newsapi.org"
        case .Production: return "https://newsapi.org"
        }
    }
}

enum ESVersion: String {
    case v1 = "v1"
    case v2 = "v2"
    case v3 = "v3"
    case none = ""
}

/// Old Single target request
class ESApiRequest: ESMultiTargetRequest {
    
    // return full url
    public var url:String {
        var url = "\(domain)/api/\(version.rawValue)/\(suffix)"
        if let params = params, params.isNotEmpty {
            url += "?\(params)"
        }
        return url
    }
    
    // return domain
    public var domain:String {
        return ESAppManager.share.environment.domain
    }
    
    // return version
    public var version:ESVersion {
        return .v1
    }
    
    // return suffix url
    public var suffix:String {
        return ""
    }
    
    // return params
    public var params:String? {
        return nil
    }
    
    var dynamicParams: [String : Any]? {
        nil
    }
    
    // return method
    public var method:HTTPMethod {
        return .get
    }
    
    // return body for post, delete, put, update request
    public var body:[String:Any]? {
        return nil
    }
    
    // return header
    public var headers:[String:String]? {
        return nil
    }
    
    // Override it if you want to put data in form data
    public func setMultipartFormData(multipartFormData: MultipartFormData) {
        
    }
}

extension ESRequest {
    
    public var appType:String {
        let target = ESAppManager.share.target ?? .Client
        switch target {
        case .Client: return "customer"
        case .Seller: return "vendor"
        }
    }
}


import Alamofire

/// Support multi target requests and implementation with Enumeration
protocol ESMultiTargetRequest {
    // Full URL
    var url: String { get }

    // Domain URL
    var domain: String { get }

    // API Version
    var version: ESVersion { get }

    // URL suffix
    var suffix: String { get }

    // Parameters
    var params: String? { get }

    // HTTP Method
    var method: HTTPMethod { get }

    // Request body for POST, DELETE, PUT, UPDATE requests
    var body: [String: Any]? { get }

    // HTTP Headers
    var headers: [String: String]? { get }

    // For multipart form data handling
    func setMultipartFormData(multipartFormData: MultipartFormData)
}

// MARK: - Default implementation
