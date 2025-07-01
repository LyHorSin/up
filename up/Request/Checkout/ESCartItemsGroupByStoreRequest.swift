//
//  ESCartItemsGroupByStoreRequest.swift
//  up
//
//  Created by Nim on 22/10/24.
//

import Foundation
import Alamofire

class ESCartItemsGroupByStoreRequest: ESApiRequest {

    override var suffix: String {
        return "cart/items/group-by-store"
    }

    override var version: ESVersion {
        return .v1
    }
    
    override var method: HTTPMethod {
        return .get
    }
    
}
