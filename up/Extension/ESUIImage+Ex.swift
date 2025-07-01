//
//  ESUIImage+Ex.swift
//  up
//
//  Created by SINN SOKLYHOR on 16/5/24.
//

import Foundation
import UIKit

extension UIImage {
    
    public func toBase64() -> String? {
        let maxFileSize = 100 * 1024 * 1024 // 100 MB in bytes
        var compression: CGFloat = 1.0
        var imageData = self.jpegData(compressionQuality: compression)
        let count = imageData?.count ?? 0
        while count > maxFileSize && compression > 0 {
            compression -= 0.1
            imageData = self.jpegData(compressionQuality: compression)
        }
        if let data = imageData {
            let base64 = data.base64EncodedString()
            return base64
        }
        return nil
    }
    
    public var uuid: UUID {
        return UUID()
    }
    
    public func toData() -> Data? {
        if let jpeg = self.jpegData(compressionQuality: 1) {
            return jpeg
        } else if let png = self.pngData() {
            return png
        }
        return nil
    }
    
    public func toCompressedData(maxSizeInMB: CGFloat = 1.0) -> Data? {
        let maxFileSize = maxSizeInMB * 1024 * 1024 // Convert MB to bytes
        var compressionQuality: CGFloat = 1.0 // Start with best quality (100%)

        // Try JPEG compression first
        guard var imageData = self.jpegData(compressionQuality: compressionQuality) else {
            return nil
        }
        
        // If the data size exceeds the limit, we will compress it iteratively
        while imageData.count > Int(maxFileSize) && compressionQuality > 0 {
            compressionQuality -= 0.1 // Reduce quality
            if let compressedData = self.jpegData(compressionQuality: compressionQuality) {
                imageData = compressedData
            }
        }
        
        // If JPEG compression fails or we hit 0 quality, we try PNG format as fallback
        if imageData.count > Int(maxFileSize) {
            if let pngData = self.pngData(), pngData.count <= Int(maxFileSize) {
                return pngData
            } else {
                // If PNG also exceeds the size, we return nil or the last reduced JPEG
                return imageData.count <= Int(maxFileSize) ? imageData : nil
            }
        }
        
        return imageData
    }

    
    public func getImagePath() -> String? {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        
        let fileURL = documentsDirectory.appendingPathComponent("\(UUID().uuidString).png")
        guard let imageData = self.pngData() else {
            return nil
        }
        
        do {
            try imageData.write(to: fileURL)
            return fileURL.absoluteString
        } catch {
            return nil
        }
    }
}
