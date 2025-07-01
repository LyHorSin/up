//
//  ESLocalizable.swift
//  up
//
//  Created by SINN SOKLYHOR on 26/4/24.
//

import Foundation

class ESLocalizable: ObservableObject {
    
    public static let share = ESLocalizable()
    
    enum Lanaguage: String, CaseIterable {
        case English = "en"
        case Khmer = "km"
        case Chinese = "zh-Hans"
        
        public var title:String {
            switch self {
            case .English: return "English"
            case .Khmer: return "Khmer"
            case .Chinese: return "Chinese"
            }
        }
        
        public var icon:String {
            switch self {
            case .English: return "language_english"
            case .Khmer: return "language_khmer"
            case .Chinese: return "language_chiness"
            }
        }
    }
    
    @Published public var local:Lanaguage = .English {
        didSet {
//            ESUserDefaultUtils.save(object: local.rawValue, forKey: USER_LANGUAGE)
        }
    }
    
    init() {
//        if let local = ESUserDefaultUtils.getObjectForKey(key: USER_LANGUAGE) as? String {
//            if let language = Lanaguage(rawValue: local) {
//                self.local = language
//            }
//        }
    }
}

extension ESLocalizable {
    
    public var availableLanguages:[Lanaguage] {
        return Lanaguage.allCases
    }
    
    public var languageCode: String {
        if local == .Chinese {
            return "zh_CN"
        } else {
            return local.rawValue
        }
    }
}
