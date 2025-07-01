//
//  ESCatcheManager.swift
//  EShopping
//
//  Created by SINN SOKLYHOR on 24/4/24.
//

import Foundation
import SDWebImage

class ESCatcheManager {
    
    class func catchInit() {
        // Add WebP/SVG/PDF support
        if #available(iOS 14.0, *) {
            SDImageCodersManager.shared.addCoder(SDImageAWebPCoder.shared)
        }
        SDImageCodersManager.shared.addCoder(SDImageAPNGCoder.shared)
        
        // Add default HTTP header
        SDWebImageDownloader.shared.setValue("image/webp,image/apng,image/*,*/*;q=0.8", forHTTPHeaderField: "Accept")
        
        // Add multiple caches
        let cache = SDImageCache(namespace: "tiny")
        cache.config.maxMemoryCost = 100 * 1024 * 1024 // 100MB memory
        cache.config.maxDiskSize = 50 * 1024 * 1024 // 50MB disk
        SDImageCachesManager.shared.addCache(cache)
        SDWebImageManager.defaultImageCache = SDImageCachesManager.shared
        SDWebImageManager.defaultImageLoader = SDImageLoadersManager.shared
    }
}
