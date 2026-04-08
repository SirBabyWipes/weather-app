//
//  UnitConversion.swift
//  WeatherApp
//
//  Created by Jadon Vanschaick on 4/5/26.
//

/*
 This file assists with necessary unit conversions between Fahrenheit and Celsius, and other units as needed.
 TODOS:
  - Create a Fahrenheit -> Celsius converter
  - Create a Celsius -> Fahrenheit converter
 */

enum UnitConversion {
    
    static func fahrenheitToCelsius(_ fahrenheit: Double) -> Double {
        return (fahrenheit - 32) * 5/9
    }
    
    static func celsiusToFahrenheit(_ celsius: Double) -> Double {
        return (celsius * 9/5) + 32
    }
    
}
