//
//  UserCache.swift
//  WeatherApp
//
//  Created by Jadon Vanschaick on 4/13/26.
//

import Foundation

final class UserCache {
    static let shared = UserCache()
    private let storage = UserDefaults.standard
    
    func setLocation(_ latitude: Float, _ longitude: Float) {
        storage.set(latitude, forKey: "latitude")
        storage.set(longitude, forKey: "longitude")
    }
    
    func getLocation() -> (Float, Float) {
        if storage.value(forKey: "latitude") == nil || storage.value(forKey: "longitude") == nil {
            return (-999, -999)
        }
        let latitude: Float = storage.value(forKey: "latitude") as! Float
        let longitude: Float = storage.value(forKey: "longitude") as! Float
        return (latitude, longitude) as (Float, Float)
    }
    
    func setCity(_ city: String) {
        storage.set(city, forKey: "city")
    }
    
    func getCity() -> String {
        if storage.value(forKey: "city") == nil {
            return "Unknown City"
        }
        let city: String = storage.value(forKey: "city") as! String
        return city
    }
    
    func setUnitPref(_ unit: String) {
        if ["C", "F"].contains(unit) {
            storage.set(unit, forKey: "unit")
        }
    }
    
    func getUnitPref() -> String {
        return storage.value(forKey: "unit") as! String
    }
}
