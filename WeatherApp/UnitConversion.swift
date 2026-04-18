//
//  UnitConversion.swift
//  WeatherApp
//
//  Created by Jadon Vanschaick on 4/5/26.
//

/*
 This file assists with necessary unit conversions between Fahrenheit and Celsius, and other units as needed.
 */

final class UnitConversion {
    
    static func fahrenheitToCelsius(_ fahrenheit: Double) -> Double {
        return (fahrenheit - 32) * 5/9
    }
    
    static func celsiusToFahrenheit(_ celsius: Double) -> Double {
        return (celsius * 9/5) + 32
    }
    
    static func mphToKph(_ mph: Double) -> Double {
        return mph * 1.60934
    }
    
    static func kphToMph(_ kph: Double) -> Double {
        return kph / 1.60934
    }
    
    static func inchToMm(_ inch: Double) -> Double {
        return inch * 25.4
    }
    
    static func mmToInch(_ mm: Double) -> Double {
        return mm / 25.4
    }
    
    
}
