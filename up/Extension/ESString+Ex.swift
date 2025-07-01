//
//  ESString+Ex.swift
//  up
//
//  Created by SINN SOKLYHOR on 27/4/24.
//

import Foundation

// Phone Number
extension String {
    
    var hexToUInt:  UInt? {
        let cleanedHex = trimmingCharacters(in: CharacterSet(charactersIn: "#"))
        return UInt(cleanedHex, radix: 16)
    }
    
    func addComma() -> String {
        self + ","
    }
    
    func addHyphen() -> String {
        self + "-"
    }
    
    func addConlon() -> String {
        self + ":"
    }
    
    func addWhiteSpace() -> String {
        self + " "
    }
    
    var base64ToImage: UIImage? {
        if let imageData = Data(base64Encoded: self) {
            let image = UIImage(data: imageData)
            return image
        }
        return nil
    }
    
    public var htmlToString: String {
        guard let data = self.data(using: .utf8) else { return self }
        do {
            let attributedString = try NSAttributedString(data: data, options: [
                .documentType: NSAttributedString.DocumentType.html,
                .characterEncoding: String.Encoding.utf8.rawValue
            ], documentAttributes: nil)
            return attributedString.string
        } catch let error {
            print("Error converting HTML to string: \(error)")
            return self
        }
    }
    
    public var toAttributedString: NSAttributedString? {
        guard let data = self.data(using: .utf8) else { return nil }
        do {
            let attributedString = try NSAttributedString(data: data, options: [
                .documentType: NSAttributedString.DocumentType.html,
                .characterEncoding: String.Encoding.utf8.rawValue
            ], documentAttributes: nil)
            return attributedString
        } catch let error {
            print("Error converting HTML to string: \(error)")
            return nil
        }
    }
    
    public var trimPhoneNumber: String {
        guard !self.isEmpty else { return self }
        var phone = self
        if phone.remove(at: phone.startIndex) == "0" {
            let string = self.dropFirst()
            return "\(string)"
        }
        return self
    }
    
    public func removePhoneCode(phoneCode: String) -> String {
        let code = phoneCode.trimPhoneCode
        if self.hasPrefix("\(code)0") {
            return String(self.dropFirst(code.count + 1))
        } else if self.hasPrefix(code) {
            return String(self.dropFirst(code.count))
        } else if self.hasPrefix("0") {
            return String(self.dropFirst(1))
        } else {
            return self
        }
    }
    
    public var trimPhoneCode: String {
        guard !self.isEmpty else { return self }
        let phoneCode = self
        if self.contains("+") {
            let string = phoneCode.dropFirst()
            return "\(string)"
        }
        return phoneCode
    }
    
    public var isPrefixedWithPhoneCode: Bool {
        first == "+" || hasPrefix("855")
    }
    
    public func displayPhoneWithCountryCode(customCode: String? = nil) -> String {
        let defaultCode = "+855"
        if isPrefixedWithPhoneCode {
            return self
        } else {
            return customCode.defaultValueIfNil(defaultCode).addWhiteSpace().appending(trimPhoneNumber)
        }
    }
    
    public var removeEmailFormat: String {
        if let atIndex = self.firstIndex(of: "@") {
            let username = String(self.prefix(upTo: atIndex))
            return username
        }
        return self
    }
}

extension String {
    
    public var uuid:UUID {
        return UUID()
    }
    
    public var isValidEmail:Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
    
    public func loadFile(ofType: String) -> URL? {
        if let path = Bundle.main.path(forResource: self, ofType: ofType) {
            let url = URL(fileURLWithPath: path)
            return url
        }
        return nil
    }
    
    public func toPrice() -> String {
        if let double = Double(self) {
            return double.toPrice()
        }
        return self
    }
    
    public func toPercentages() -> String {
        if let double = Double(self) {
            return double.toPercentages()
        } else if let interger = Int(self) {
            return "\(interger)%"
        }
        return self
    }
    
    public func toNumber() -> Double {
        if let double = Double(self) {
            return double
        } else if let interger = Int(self) {
            return Double(interger)
        }
        return 0
    }
    
    public func addSuffixStar() -> String {
        let str = self
        if str.count > 4 {
            let midIndex = str.index(str.startIndex, offsetBy: str.count / 2)
            let firstHalf = str[..<midIndex]
            let starsCount = str.count - firstHalf.count
            let starPart = String(repeating: "*", count: starsCount)
            return firstHalf + starPart
        }
        return str
    }
}

extension Dictionary {
    
    func toJsonString() -> String? {
        if let jsonData = try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted) {
            return String(data: jsonData, encoding: .utf8)
        }
        return nil
    }
}


// URL
extension String {
    
    public func toUrl() -> URL? {
        guard self.contains("https") || self.contains("http") else { return nil }
        if let encodedString = self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
           let url = URL(string: encodedString) {
            return url
        }
        return URL(string: self)
    }
    
    public func toInt() -> Int? {
        if let int = Int(self) {
            return int
        }
        return nil
    }
    
    public func removePathSegment(segmentToRemove: String) -> String {
        guard let url = URL(string: self) else {
            return self
        }

        // Construct the new path without the segment
        var newPath = url.path
        if newPath.hasSuffix(segmentToRemove) {
            newPath = String(newPath.dropLast(segmentToRemove.count))
        }

        // Construct the new URL
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        components?.path = newPath

        return components?.url?.absoluteString ?? self
    }
    
    public func isFileUrl() -> Bool {
        // Convert the string to a URL
        guard let url = URL(string: self) else {
            return false
        }
        
        // Check if the URL is a file URL
        guard url.isFileURL else {
            return false
        }
        
        // Check if the file exists at the URL
        let fileManager = FileManager.default
        return fileManager.fileExists(atPath: url.path)
    }
    
    public func isUrl() -> Bool {
        // Convert the string to a URL
        guard let _ = URL(string: self) else {
            return false
        }
        return true 
    }
}

// MARK date
extension String {
    
    public var toDateFormatFromUTCToHhMmDdMmYyyy: String {
        // Step 1: Create a DateFormatter to parse the original date string
        let inputDateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss zzz"
        inputDateFormatter.locale = Locale(identifier: "en_US_POSIX")

        // Convert the date string to a Date object
        if let date = inputDateFormatter.date(from: self) {
            
            // Step 2: Create a DateFormatter to format the Date object to the desired format
            let outputDateFormatter = DateFormatter()
            outputDateFormatter.dateFormat = "HH:mm, dd/MM/yyyy"
            outputDateFormatter.locale = Locale(identifier: "en_US_POSIX")
            
            // Convert the Date object to the desired date string format
            let formattedDateString = outputDateFormatter.string(from: date)
            
            return formattedDateString
        } else {
            return self
        }
    }
    
    public var toDateFormatFromUTCToHhMm: String {
        // Step 1: Create a DateFormatter to parse the original date string
        let inputDateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss zzz"
        inputDateFormatter.locale = Locale(identifier: "en_US_POSIX")

        // Convert the date string to a Date object
        if let date = inputDateFormatter.date(from: self) {
            
            // Step 2: Create a DateFormatter to format the Date object to the desired format
            let outputDateFormatter = DateFormatter()
            outputDateFormatter.dateFormat = "HH:mm a"
            outputDateFormatter.locale = Locale(identifier: "en_US_POSIX")
            
            // Convert the Date object to the desired date string format
            let formattedDateString = outputDateFormatter.string(from: date)
            
            return formattedDateString
        } else {
            return self
        }
    }
    
    public var toDateFormatHhMmDdMmYyyy: String {
        let local = ESLocalizable.share.local.rawValue
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        dateFormatter.locale = Locale(identifier: local)
        guard let date = dateFormatter.date(from:self) else { return self }
        
        dateFormatter.dateFormat = "HH:mm, dd/MM/yyyy"
        let newDateStr = dateFormatter.string(from: date)
        
        return newDateStr
    }
    
    public var toDateFormatFromUTCToDayAndHour: String {
        let inputDateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss zzz"
        inputDateFormatter.locale = Locale(identifier: "en_US_POSIX")

        if let date = inputDateFormatter.date(from: self) {
            
            let calendar = Calendar.current
            if calendar.isDateInToday(date) {
                let outputDateFormatter = DateFormatter()
                outputDateFormatter.dateFormat = "HH:mm"
                outputDateFormatter.locale = Locale(identifier: "en_US_POSIX")
                return outputDateFormatter.string(from: date)
            } else {
                let outputDateFormatter = DateFormatter()
                outputDateFormatter.dateFormat = "HH:mm, dd/MM/yyyy"
                outputDateFormatter.locale = Locale(identifier: "en_US_POSIX")
                return outputDateFormatter.string(from: date)
            }
        } else {
            return self
        }
    }
    
    public var toDateFormatYyyyMmDd: String {
        let local = ESLocalizable.share.local.rawValue
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"
        dateFormatter.locale = Locale(identifier: local)
        guard let date = dateFormatter.date(from:self) else { return self }
        
        dateFormatter.dateFormat = "yy.MM.dd"
        let newDateStr = dateFormatter.string(from: date)
        
        return newDateStr
    }
    
    public var toDateFormatddMMyyyy: String {
        let local = ESLocalizable.share.local.rawValue
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"
        dateFormatter.locale = Locale(identifier: local)
        guard let date = dateFormatter.date(from:self) else { return self }
        
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let newDateStr = dateFormatter.string(from: date)
        
        return newDateStr
    }
    
    public var toDateFormatDdMmYyyy: String {
        let local = ESLocalizable.share.local.rawValue
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"
        dateFormatter.locale = Locale(identifier: local)
        guard let date = dateFormatter.date(from:self) else { return self }
        
        dateFormatter.dateFormat = "dd.MM.yy"
        let newDateStr = dateFormatter.string(from: date)
        
        return newDateStr
    }
    
    public func toISODate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        if let date = dateFormatter.date(from: self) {
            return date
        } else {
            return nil
        }
    }
}
extension String {
    public func formatDateString(outputFormat: String = "HH:mm, dd/MM/yyyy") -> String? {
        // Ensure that your input date format matches the format of `self`
        let inputDateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"
        inputDateFormatter.timeZone = TimeZone(abbreviation: "UTC")

        guard let date = inputDateFormatter.date(from: self) else {
            print("Error: Unable to parse date string.")
            return nil
        }
        
        let outputDateFormatter = DateFormatter()
        outputDateFormatter.dateFormat = outputFormat // Desired format

        return outputDateFormatter.string(from: date)
    }
    
    public func formatTimeDateString() -> String? {
        // Ensure that your input date format matches the format of `self`
        let inputDateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        inputDateFormatter.timeZone = TimeZone(abbreviation: "UTC")

        guard let date = inputDateFormatter.date(from: self) else {
            print("Error: Unable to parse date string.")
            return nil
        }
        
        let outputDateFormatter = DateFormatter()
        outputDateFormatter.dateFormat = "HH:mm d/M/yyyy"

        return outputDateFormatter.string(from: date)
    }
    
}

extension String {
    
    public func openAppOrBrowser(completation: ((_ canOpen: Bool)-> Void)? = nil) {
        guard let url = URL(string: self) else {
            completation?(false)
            return
        }
        // Try to open the URL as an app first
        UIApplication.shared.open(url, options: [:]) { success in
            if !success {
                // If the app can't be opened, fall back to opening it in the browser
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
            completation?(success)
        }
    }
}

extension String {
    
    func toMonthDay() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        if let date = dateFormatter.date(from: self) {
            let monthDayFormatter = DateFormatter()
            monthDayFormatter.dateFormat = "MM/dd"
            return monthDayFormatter.string(from: date)
        }
        
        return nil
    }
    
    func toMonth() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        if let date = dateFormatter.date(from: self) {
            let monthFormatter = DateFormatter()
            monthFormatter.dateFormat = "MM"
            return monthFormatter.string(from: date)
        }
        
        return nil
    }
    
    func toDay() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        if let date = dateFormatter.date(from: self) {
            let monthDayFormatter = DateFormatter()
            monthDayFormatter.dateFormat = "dd"
            return monthDayFormatter.string(from: date)
        }
        
        return nil
    }
    
    func toFormattedRevenueDate() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        if let date = dateFormatter.date(from: self) {
            let calendar = Calendar.current
            let currentDate = Date()
            
            // Check if the date is today
            if calendar.isDateInToday(date) {
                let dayFormatter = DateFormatter()
                dayFormatter.dateFormat = "dd/MM"  // Format for "Today"
                return dayFormatter.string(from: date)
            }
            
            // Check if the date is the first day of the month
            let currentYear = calendar.component(.year, from: currentDate)
            let currentMonth = calendar.component(.month, from: currentDate)
            let dateYear = calendar.component(.year, from: date)
            let dateMonth = calendar.component(.month, from: date)
            
            if currentYear == dateYear && currentMonth == dateMonth && calendar.component(.day, from: date) == 1 {
                // If it's the first day of the current month, show just "dd"
                let dayFormatter = DateFormatter()
                dayFormatter.dateFormat = "dd/MM"
                return dayFormatter.string(from: date)
            }
            
            // For all other dates, show in "dd" format
            let monthDayFormatter = DateFormatter()
            monthDayFormatter.dateFormat = "dd"
            return monthDayFormatter.string(from: date)
        }
        
        return nil
    }
    
    func toDailyMonth() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        if let date = dateFormatter.date(from: self) {
            let monthFormatter = DateFormatter()
            monthFormatter.dateFormat = "MMM"  // "MMM" will give you the month abbreviation, like "Jan"
            
            let calendar = Calendar.current
            let today = calendar.startOfDay(for: Date())  // Start of today (midnight)
            let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: date))! // Start of the month
            
            // Check if the date is today
            if calendar.isDate(date, inSameDayAs: today) {
                return "Today"  // Return "Today" if the date is today
            }
            
            // Check if the date is the start of the month
            if calendar.isDate(date, inSameDayAs: startOfMonth) {
                return monthFormatter.string(from: date)  // Return the abbreviated month name if it's the start of the month
            }
            
            return nil  // Return nil if the date is neither today nor the start of the month
        }
        return nil
    }
}
extension String {
    public var localized: String {
        let code = ESLocalizable.share.local.rawValue
        if let langPath = Bundle.main.path(forResource: code, ofType: "lproj"),
           let langBundle = Bundle(path: langPath) {
            let value = langBundle.localizedString(forKey: self, value: nil, table: nil)
            return value != self ? value : self
        }
        return self
    }
}
