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
        let location: (Float, Float) = (latitude, longitude)
        storage.set(location, forKey: "location")
    }
    
    func getLocation() -> (Float, Float)? {
        return storage.value(forKey: "location") as? (Float, Float)
    }
    
    func setCity(_ city: String) {
        storage.set(city, forKey: "city")
    }
    
    func getCity() -> String? {
        return storage.value(forKey: "city") as? String
    }
    
    func setUnitPref(_ unit: Character) {
        if ["c", "f"].contains(unit) {
            storage.set(unit, forKey: "unit")
        }
    }
    
    func getUnitPref() -> Character? {
        return storage.value(forKey: "unit") as? Character
    }
}
