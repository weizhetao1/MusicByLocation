//
//  LocationHandler.swift
//  MusicByLocation
//
//  Created by Tao, Weizhe (Coll) on 26/02/2022.
//

import Foundation
import CoreLocation

class LocationHandler: NSObject, CLLocationManagerDelegate, ObservableObject {
    let manager = CLLocationManager()
    let geocoder = CLGeocoder()
    @Published var lastKnownLocation: [String: String] = [:]
    
    override init() {
        super.init()
        manager.delegate = self
    }
    
    func requestAuthorisation() {
        manager.requestWhenInUseAuthorization()
    }
    
    func requestLocation() {
        manager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let firstLocation = locations.first {
            geocoder.reverseGeocodeLocation(firstLocation, completionHandler: { (placemarks, error) in
                if error != nil {
                    self.lastKnownLocation["Error"] = "Could not perform lookup of location from coordinate information"
                } else {
                    if let firstPlacemark = placemarks?[0] {
                        self.lastKnownLocation["City"] = firstPlacemark.locality ?? "Couldn't find locality"
                        self.lastKnownLocation["Country"] = firstPlacemark.country ?? "Couldn't find country"
                        self.lastKnownLocation["State / Province"] = firstPlacemark.administrativeArea ?? "Couldn't find State / Province"
                        self.lastKnownLocation["Street"] = firstPlacemark.thoroughfare ?? "Couldn't find street"
                        self.lastKnownLocation["Altitude"] = String(firstLocation.altitude)
                        self.lastKnownLocation["Latitude"] = String(firstLocation.coordinate.latitude)
                        self.lastKnownLocation["Longitude"] = String(firstLocation.coordinate.longitude)
                    }
                }
            })
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        lastKnownLocation["Error"] = "Error finding location"
    }
}
