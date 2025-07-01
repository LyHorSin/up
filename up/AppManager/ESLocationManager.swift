//
//  ESLocationManager.swift
//  up
//
//  Created by Ly Hor Sin on 17/6/24.
//

import Foundation
import GoogleSignIn
import CoreLocation

class ESLocationManager: NSObject {
    
    public static let share = ESLocationManager()
    
    public var authorizationStatus: Bool {
        let status = self.locationManager.authorizationStatus
        let authorizedAlways = status == .authorizedAlways
        let authorizedWhenInUse = status == .authorizedWhenInUse
        let authorized = authorizedAlways || authorizedWhenInUse
        return authorized
    }
    
    private let locationManager = CLLocationManager()
    
    public func configProviderAPIKey() {
        if let configuration = ESAppConfiguration.share.configuration {
//            if let service = configuratios.google?.mapServiceKey {
//                GMSServices.provideAPIKey(service)
//            }
//            if let place = configuratios.google?.mapPlaceClientKey {
//                GMSPlacesClient.provideAPIKey(place)
//            }
            if let client = configuration.google?.clientKey {
                GIDSignIn.sharedInstance.configuration = .init(clientID: client)
            }
        }
        
//        self.requestLocationService { authorization in }
    }
    
    public func requestLocationService(completation: @escaping ((_ authorization:Bool) -> Void)) {
        
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
}
