//
//  UnitConversion.swift
//  WeatherApp
//
//  Created by Jadon Vanschaick on 4/5/26.
//

/*
 This file assists with necessary unit conversions between Fahrenheit and Celsius, and other units as needed.
 */
import SwiftUI

final class UnitConversion {
    
    static func fahrenheitToCelsius(_ fahrenheit: Float) -> Float {
        return (fahrenheit - 32) * 5/9
    }
    
    static func celsiusToFahrenheit(_ celsius: Float) -> Float {
        return (celsius * 9/5) + 32
    }
    
    static func mphToKph(_ mph: Float) -> Float {
        return mph * 1.60934
    }
    
    static func kphToMph(_ kph: Float) -> Float {
        return kph / 1.60934
    }
    
    static func inchToMm(_ inch: Float) -> Float {
        return inch * 25.4
    }
    
    static func mmToInch(_ mm: Float) -> Float {
        return mm / 25.4
    }
    
}


