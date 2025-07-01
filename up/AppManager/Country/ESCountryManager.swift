//
//  ESCountryManager.swift
//  STC
//
//  Created by Ly Hor Sin on 21/9/23.
//

import Foundation
import SwiftyJSON

class ESCountryManager: ObservableObject {
    
    @Published var countries:[ESCountry] = []
    @Published var currentCountry:ESCountry?
    @Published var searchText:String = ""
    
    init() {
        self.loadCountry()
        if currentCountry == nil {
            currentCountry = countries.filter({$0.countryCode == "KH"}).first
        }
    }
}

extension ESCountryManager {
    
    private func loadCountry() {
        do {
           if let bundlePath = Bundle.main.path(forResource: "country_code", ofType: "json"),
           let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
               if let arrJson = JSON(jsonData).array {
                   for json in arrJson {
                       if let data = json.dictionaryObject {
                           countries.append(ESCountry.getCountry(dict: data))
                       }
                   }
               }
           }
        } catch {
           
        }
    }
    
    public func updateCurrentCountry(country: ESCountry) {
        self.currentCountry = country
    }
    
    public var searchCountries:[ESCountry] {
        if searchText.isEmpty {
            return countries
        } else {
            return countries.filter({($0.name ?? "").contains(searchText)})
        }
    }
}

extension ESCountryManager {
    
    public func getPhoneNumber(phone: String) -> String {
        let phoneCode = self.currentCountry?.phoneCode ?? ""
        return "\(phoneCode)\(phone)"
    }
}
