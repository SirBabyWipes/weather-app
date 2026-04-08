//
//  WeatherData.swift
//  WeatherApp
//
//  Created by Jadon Vanschaick on 4/5/26.
//

/*
 We want to retrieve weather data using API Calls in this app.
 TODOS:
  - Take user input for city/state/country
  - Make API Call to gather latitude/longitude for this location
  - Extract latitude/longitude and use it to make an API call for weather at that location
  - Extract results
  - Send results to frontend for rendering
 
 Sample API link: https://api.open-meteo.com/v1/forecast?latitude=52.52&longitude=13.41&daily=temperature_2m_max,temperature_2m_min,precipitation_probability_max,cloud_cover_mean&hourly=temperature_2m,precipitation_probability,precipitation,cloud_cover&current=temperature_2m,relative_humidity_2m,precipitation,cloud_cover,wind_speed_10m&timezone=America%2FNew_York&wind_speed_unit=mph&temperature_unit=fahrenheit&precipitation_unit=inch
 
 *** We fetch weather data from open-meteo. It is a free API which does not require an API key.
 */

import Foundation

// Holds the possible return types from the api logic
enum WeatherResponseType {
    case success(WeatherData)
    case failure(WeatherFail)
}

// Failure object returned by the WeatherAPI if an issue occurs in the process. Code will tell what type, message has details
struct WeatherFail {
    let message: String
    /*
     Codes:
      - 1: Location not found
      - 2: API returned failure
      - 3: Miscellaneous error (Logic error unrelated to API)
     */
    let code: Int
}

// Holds the weather api response data to be used by app UI
struct WeatherData: Codable {
    let current: CurrentData
    let hourly: HourlyData
    let daily: DailyData
    
    struct CurrentData: Codable {
        let currentTemperature: String
        let relativeHumidity: String
        let windSpeed: Float
        let precipitation: Float
        let cloudCover: Float
        
        // Maps the JSON keys to struct keys; helps due to camelCase vs snake_case
        enum CodingKeys: String, CodingKey {
            case currentTemperature = "temperature_2m"
            case relativeHumidity = "relative_humidity_2m"
            case windSpeed = "wind_speed_10m"
            case precipitation = "precipitation"
            case cloudCover = "cloud_cover"
        }
    }
    
    struct HourlyData: Codable {
        let timeHourly: [Date]
        let temperatureHourly: [Float]
        let cloudCoverHourly: [Float]
        let precipitationHourly: [Float]
        let precipitationProbabilityHourly: [Float]
        
        enum CodingKeys: String, CodingKey {
            case timeHourly = "time"
            case temperatureHourly = "temperature_2m"
            case cloudCoverHourly = "cloud_cover"
            case precipitationHourly = "precipitation"
            case precipitationProbabilityHourly = "precipitation_probability"
        }
    }
    
    struct DailyData: Codable {
        let timeDaily: [Date]
        let temperatureMaxDaily: [Float]
        let temperatureMinDaily: [Float]
        let precipitationProbabilityMaxDaily: [Float]
        let cloudCoverMeanDaily: [Float]
        
        enum CodingKeys: String, CodingKey {
            case timeDaily = "time"
            case temperatureMaxDaily = "temperature_2m_max"
            case temperatureMinDaily = "temperature_2m_min"
            case precipitationProbabilityMaxDaily = "precipitation_probability_max"
            case cloudCoverMeanDaily = "cloud_cover_mean"
        }
    }
}

// Contains the API call functionality and builds the WeatherData with response
struct WeatherAPI {
    // Builds the API url which will get the weather. Latitude and longitude needs to be defined
    func buildURL(latitude: Float, longitude: Float) -> URL {
            return URL(string:"https://api.open-meteo.com/v1/forecast?latitude=\(latitude)&longitude=\(longitude)&daily=temperature_2m_max,temperature_2m_min,precipitation_probability_max,cloud_cover_mean&hourly=temperature_2m,cloud_cover,precipitation,precipitation_probability¤t=temperature_2m,relative_humidity_2m,apparent_temperature,wind_speed_10m,wind_direction_10m,precipitation,cloud_cover,rain,showers,snowfall&timezone=America%2FNew_York&wind_speed_unit=mph&temperature_unit=fahrenheit&precipitation_unit=inch&format=flatbuffers")!
    }
    
    // Takes a user input for the city name and fetches the latitude and longitude of that location
    func getLatitudeAndLongitude(city: String = "Charlotte") async throws -> (Float, Float) {
        // Returns Charlotte's latitude and longitude by default
        return (35.22709, -80.84313)
    }
    
    // Makes the API call for the weather
    func getWeather(city: String) async throws -> WeatherData {
        // Make call to getLatitudeAndLongitude and destructure results into latitude and longitude
        let (latitude, longitude) = try await getLatitudeAndLongitude(city: city)
        // Using these results build the API URL
        let apiURL = buildURL(latitude: latitude, longitude: longitude)
        // Make API call
        
        // Parse JSON results into WeatherData
        
        // Return WeatherData
    }
    
    // Gets user cache if it exists
    func getWeatherCache() {
        
    }
    
    // Sets user cache for future reference
    func setWeatherCache() {
        
    }
    
}
