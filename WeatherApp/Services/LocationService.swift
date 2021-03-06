//
//  MapService.swift
//  WeatherApp
//
//  Created by Тимофей Лукашевич on 18.09.20.
//  Copyright © 2020 Тимофей Лукашевич. All rights reserved.
//

import MapKit
import CoreLocation

protocol UpdateDelegateProtocol: class {
    func lokationDidUpdate()
}


protocol LocationServiceProtocol {
    var currentLat: Int {get}
    var currentLong: Int {get}
    var delegates: [UpdateDelegateProtocol] {get set}
}


class CurrentLokationTaker: NSObject,LocationServiceProtocol,  CLLocationManagerDelegate {
    
    var currentLat: Int = 0
    var currentLong: Int = 0
    var delegates: [UpdateDelegateProtocol] = []
    
    var locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.distanceFilter = 6000
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        currentLat = Int(locValue.latitude)
        currentLong = Int(locValue.longitude)
        for delegate in delegates {
            delegate.lokationDidUpdate()
        }
    }
   
}
