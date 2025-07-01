//
//  ESDeviceManager.swift
//  up
//
//  Created by Admin on 9/3/24.
//
import Foundation
import UIKit

import Foundation
import UIKit

// A class to manage device-related functionalities
class ESDeviceManager {
    
    // Function to get the hardware identifier of the device
    static private func getDeviceIdentifier() -> String? {
        var systemInfo = utsname()
        uname(&systemInfo)
        
        // Convert the `machine` field of `utsname` to a string
        let modelCode = withUnsafePointer(to: &systemInfo.machine) { pointer in
            // Access the raw pointer and create a string from it
            let cString = UnsafeRawPointer(pointer).assumingMemoryBound(to: CChar.self)
            return String(cString: cString)
        }
        return modelCode
    }
    
    // Function to check if the device is iPhone X or later
    static func isIPhoneXOrLater() -> Bool {
        guard let modelCode = getDeviceIdentifier() else {
            return false
        }
        
        let iPhoneXAndLaterIdentifiers: Set<String> = [
            "iPhone10,3", // iPhone X
            "iPhone10,6", // iPhone X
            "iPhone11,2", // iPhone XS
            "iPhone11,4", // iPhone XS Max
            "iPhone11,6", // iPhone XS Max
            "iPhone11,8", // iPhone XR
            "iPhone12,1", // iPhone 11
            "iPhone12,3", // iPhone 11 Pro
            "iPhone12,5", // iPhone 11 Pro Max
            "iPhone13,1", // iPhone 12 mini
            "iPhone13,2", // iPhone 12
            "iPhone13,3", // iPhone 12 Pro
            "iPhone13,4", // iPhone 12 Pro Max
            "iPhone14,4", // iPhone 13 mini
            "iPhone14,5", // iPhone 13
            "iPhone14,2", // iPhone 13 Pro
            "iPhone14,3", // iPhone 13 Pro Max
            "iPhone14,7", // iPhone 14
            "iPhone14,8", // iPhone 14 Plus
            "iPhone15,2", // iPhone 14 Pro
            "iPhone15,3", // iPhone 14 Pro Max
            "iPhone15,4", // iPhone 15
            "iPhone15,5", // iPhone 15 Plus
            "iPhone16,1", // iPhone 15 Pro
            "iPhone16,2", // iPhone 15 Pro Max
            // Add more identifiers as needed
        ]
        
        return iPhoneXAndLaterIdentifiers.contains(modelCode)
    }
    
    // Function to check if the device is iPhone X or later
    static func smallScreeniPhoneIdentifiers() -> Bool {
        guard let modelCode = getDeviceIdentifier() else {
            return false
        }
        
        let smallScreeniPhoneIdentifiers: Set<String> = [
            // iPhone 6 Series
            "iPhone7,2",  // iPhone 6
            
            // iPhone 6s Series
            "iPhone8,1",  // iPhone 6s
            
            // iPhone SE Series
            "iPhone8,4",  // iPhone SE (1st generation)
            "iPhone12,8", // iPhone SE (2nd generation)
            "iPhone15,6", // iPhone SE (3rd generation)
            
            // iPhone 7 Series
            "iPhone9,1",  // iPhone 7
            "iPhone9,3",  // iPhone 7
            
            // iPhone 8 Series
            "iPhone10,1", // iPhone 8
            "iPhone10,4", // iPhone 8
            
            // iPhone 12 mini
            "iPhone13,1", // iPhone 12 mini
            
            // iPhone 13 mini
            "iPhone14,4", // iPhone 13 mini
        ]
        
        return smallScreeniPhoneIdentifiers.contains(modelCode)
    }
}
