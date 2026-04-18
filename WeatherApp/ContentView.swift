//
//  ContentView.swift
//  WeatherApp
//
//  Created by John Shanahan on 3/2/26.
//

import SwiftUI

struct ContentView: View {
    @State private var weatherData: WeatherData?
    @State private var ConvertUnits = false
    var body: some View {
        VStack(spacing: 20) {
            ScrollView(.vertical, showsIndicators: false) {
                if let weatherData {
                    Spacer()
                    // Location Button
                    HStack{
                        Image(systemName: "location.north.circle")
                        // Button Action
                        Button("Location") {
                            
                        }.foregroundStyle(.black)
                        Spacer()
                        VStack{
                            Toggle("", isOn: $ConvertUnits)
                            if !ConvertUnits {
                                Text("Imperial")
                                    .padding(-5)
                            } else {
                                Text("Metric")
                                    .padding(-5)
                            }
                        }
                        .frame(width: 60)
                        
                        
                        
                    }.padding()
                    
                    
                    // General Weather Icon
                    if weatherData.current.precipitation > 50 {
                        Image(systemName: "cloud.bolt.rain.fill")
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(.white, .blue)
                            .font(.system(size: 150))
                    } else if weatherData.current.precipitation > 20 {
                        Image(systemName: "cloud.rain.fill")
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(.white, .blue)
                            .font(.system(size: 150))
                    } else if weatherData.current.cloudCover > 66 {
                        Image(systemName: "cloud.fill")
                            .foregroundStyle(.gray)
                            .font(.system(size: 150))
                    } else if weatherData.current.cloudCover > 33 {
                        Image(systemName: "cloud.sun.fill")
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(.white, .yellow)
                            .font(.system(size: 150))
                    } else {
                        Image(systemName: "sun.max.fill")
                            .foregroundStyle(.yellow)
                            .font(.system(size: 150))
                    }
                    
                    VStack(spacing: 20){
                        // Temperature
                        
                        let currentTemp = weatherData.current.currentTemperature
                        if !ConvertUnits {
                            Text("\(currentTemp.formatted(.number.precision(.fractionLength(0))))°")
                                .font(.system(size: 45, weight: .bold))
                                .padding(.leading)
                        } else {
                            Text("\(UnitConversion.fahrenheitToCelsius(currentTemp).formatted(.number.precision(.fractionLength(0))))°")
                                .font(.system(size: 45, weight: .bold))
                                .padding(.leading)
                        }

                        
                        
                        // High and Low
                        let dailyHigh = weatherData.daily.temperatureMaxDaily[0]
                        let dailylow = weatherData.daily.temperatureMinDaily[0]
                        if !ConvertUnits {
                            Text("H: \(dailyHigh.formatted(.number.precision(.fractionLength(0))))°  L: \(dailylow.formatted(.number.precision(.fractionLength(0))))°")
                                .font(.system(size: 20, weight: .bold))
                                .padding(-10)
                        } else {
                            Text("H: \(UnitConversion.fahrenheitToCelsius(dailyHigh).formatted(.number.precision(.fractionLength(0))))°  L: \(UnitConversion.fahrenheitToCelsius(dailylow).formatted(.number.precision(.fractionLength(0))))°")
                                .font(.system(size: 20, weight: .bold))
                                .padding(-10)
                        }
                    }.padding()
                    
                    
                    
                    // First Card
                    HStack(){
                        Image(systemName: "drop")
                        Text("\(weatherData.current.precipitation.formatted(.number.precision(.fractionLength(0))))%")
                            .padding(.trailing, 30)
                        
                        Image(systemName: "humidity")
                        Text("\(weatherData.current.relativeHumidity.formatted(.number.precision(.fractionLength(0))))%")
                            .padding(.trailing, 30)
                        
                        Image(systemName: "wind")
                        let windSpeed = weatherData.current.windSpeed
                        if !ConvertUnits {
                            Text("\(windSpeed.formatted(.number.precision(.fractionLength(0)))) mph")
                                .padding(.trailing, 30)
                        } else {
                            Text("\(UnitConversion.mphToKph(windSpeed).formatted(.number.precision(.fractionLength(0)))) km/h")
                                .padding(.trailing, 30)
                        }
                        
                        
                        
                    }
                    .frame(width: 330)
                    .padding()
                    .foregroundColor(.white)
                    .background(.black)
                    .cornerRadius(20)
                    
                    // Second Card
                    VStack(){
                        HStack(){
                            Text("Today")
                                .foregroundColor(.white)
                                .padding(.trailing, 115)
                            Text("\(weatherData.hourly.timeHourly[0], format: .dateTime.weekday(.wide).month(.abbreviated).day())")
                                .foregroundColor(.white)
                                .padding(.leading, 30)
                        }.padding(.bottom)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 20) {
                                let startIndex = Calendar.current.component(.hour, from: Date())
                                let endIndex = min(startIndex + 25, weatherData.hourly.timeHourly.count)
                                ForEach(Array(startIndex..<endIndex), id: \.self) { x in
                                    VStack(spacing: 8) {
                                        Text("\(weatherData.hourly.timeHourly[x], format: .dateTime.hour())")
                                            .font(.system(size: 14))
                                        
                                        if weatherData.hourly.precipitationHourly[x] > 50 {
                                            Image(systemName: "cloud.bolt.rain.fill")
                                                .symbolRenderingMode(.palette)
                                                .foregroundStyle(.white, .blue)
                                        } else if weatherData.hourly.precipitationHourly[x] > 20 {
                                            Image(systemName: "cloud.rain.fill")
                                                .symbolRenderingMode(.palette)
                                                .foregroundStyle(.white, .blue)
                                        } else if weatherData.hourly.cloudCoverHourly[x] > 66 {
                                            Image(systemName: "cloud.fill")
                                                .foregroundStyle(.gray)
                                        } else if weatherData.hourly.cloudCoverHourly[x] > 33 {
                                            Image(systemName: "cloud.sun.fill")
                                                .symbolRenderingMode(.palette)
                                                .foregroundStyle(.white, .yellow)
                                        } else {
                                            Image(systemName: "sun.max.fill")
                                                .foregroundStyle(.yellow)
                                        }
                                        if !ConvertUnits {
                                            Text("\(weatherData.hourly.temperatureHourly[x].formatted(.number.precision(.fractionLength(0))))°")
                                                .font(.system(size: 18))
                                        } else {
                                            Text("\(UnitConversion.fahrenheitToCelsius(weatherData.hourly.temperatureHourly[x]).formatted(.number.precision(.fractionLength(0))))°")
                                                .font(.system(size: 18))
                                        }
                                        
                                    }
                                    .foregroundColor(.white)
                                }
                            }
                        }
                        
                    }
                    .frame(width: 330)
                    .padding()
                    .background(.black)
                    .cornerRadius(20)
                    
                    // Third Card
                    VStack(spacing: 12) {
                        HStack(){
                            Text("Daily Forecast")
                                .font(.title3)
                            Spacer()
                        }
                        
                        ForEach(0..<7) { x in
                            HStack {
                                let dailyHigh = weatherData.daily.temperatureMaxDaily[x]
                                let dailylow = weatherData.daily.temperatureMinDaily[x]
                                
                                if x == 0{
                                    Text("Today")
                                    if weatherData.daily.precipitationProbabilityMaxDaily[x] > 50 {
                                        Image(systemName: "cloud.bolt.rain.fill")
                                            .symbolRenderingMode(.palette)
                                            .foregroundStyle(.white, .blue)
                                    } else if weatherData.daily.precipitationProbabilityMaxDaily[x] > 20 {
                                        Image(systemName: "cloud.rain.fill")
                                            .symbolRenderingMode(.palette)
                                            .foregroundStyle(.white, .blue)
                                    } else if weatherData.daily.cloudCoverMeanDaily[x] > 66 {
                                        Image(systemName: "cloud.fill")
                                            .foregroundStyle(.gray)
                                    } else if weatherData.daily.cloudCoverMeanDaily[x] > 33 {
                                        Image(systemName: "cloud.sun.fill")
                                            .symbolRenderingMode(.palette)
                                            .foregroundStyle(.white, .yellow)
                                    } else {
                                        Image(systemName: "sun.max.fill")
                                            .foregroundStyle(.yellow)
                                    }
                                    if !ConvertUnits {
                                        Text("H: \(dailyHigh.formatted(.number.precision(.fractionLength(0))))°  L: \(dailylow.formatted(.number.precision(.fractionLength(0))))°")
                                    } else {
                                        Text("H: \(UnitConversion.fahrenheitToCelsius(dailyHigh).formatted(.number.precision(.fractionLength(0))))°  L: \(UnitConversion.fahrenheitToCelsius(dailylow).formatted(.number.precision(.fractionLength(0))))°")
                                    }
                                    
                                } else{
                                    Text("\(weatherData.daily.timeDaily[x], format: .dateTime.weekday())")
                                    if weatherData.daily.precipitationProbabilityMaxDaily[x] > 50 {
                                        Image(systemName: "cloud.bolt.rain.fill")
                                            .symbolRenderingMode(.palette)
                                            .foregroundStyle(.white, .blue)
                                    } else if weatherData.daily.precipitationProbabilityMaxDaily[x] > 20 {
                                        Image(systemName: "cloud.rain.fill")
                                            .symbolRenderingMode(.palette)
                                            .foregroundStyle(.white, .blue)
                                    } else if weatherData.daily.cloudCoverMeanDaily[x] > 66 {
                                        Image(systemName: "cloud.fill")
                                            .foregroundStyle(.gray)
                                    } else if weatherData.daily.cloudCoverMeanDaily[x] > 33 {
                                        Image(systemName: "cloud.sun.fill")
                                            .symbolRenderingMode(.palette)
                                            .foregroundStyle(.white, .yellow)
                                    } else {
                                        Image(systemName: "sun.max.fill")
                                            .foregroundStyle(.yellow)
                                    }
                                    if !ConvertUnits {
                                        Text("H: \(dailyHigh.formatted(.number.precision(.fractionLength(0))))°  L: \(dailylow.formatted(.number.precision(.fractionLength(0))))°")
                                    } else {
                                        Text("H: \(UnitConversion.fahrenheitToCelsius(dailyHigh).formatted(.number.precision(.fractionLength(0))))°  L: \(UnitConversion.fahrenheitToCelsius(dailylow).formatted(.number.precision(.fractionLength(0))))°")
                                    }
                                }
                            }
                        }
                    }
                    .foregroundColor(.white)
                    .frame(width: 330)
                    .padding()
                    .background(.black)
                    .cornerRadius(20)
                    
                } else {
                    // loading view
                    VStack(spacing: 100) {
                        Spacer()
                        Text("Loading Weather...")
                            .font(.title)
                    }
                    .frame(maxWidth: .infinity)
                    
                }
            }
            .padding()
            .background(.cyan)
            .ignoresSafeArea()
            .task {
                await fetchWeather()
            }
        }
        .padding()
        .background(.cyan)
        .ignoresSafeArea()
        .task {
            await fetchInitWeather()
        }
    }
    // Creates the API for all weatherdata related logic
    let api = WeatherAPI()
    
    // Fetches the initial weather data on startup, uses userCache
    func fetchInitWeather() async {
        do {
            let _ = try await api.getWeather(useCache: true)
            print(UserDefaults.standard.dictionaryRepresentation()) // For debug purposes, to see the UserDefaults cache
            // **** THIS WIPES THE APP'S CACHE - USE FOR DEBUG AND UNCOMMENT AS NEEDED
            if let bundleID = Bundle.main.bundleIdentifier {
                UserDefaults.standard.removePersistentDomain(forName: bundleID)
                UserDefaults.standard.synchronize()
            }
        } catch {
            print("Error", error)
        }
    }
    func fetchWeather() async {
        let api = WeatherAPI()
        
        do {
            let (lat, lon) = try await api.getLatitudeAndLongitude(city: "Charlotte")
            
            print("Latitude:", lat)
            print("Longitude:", lon)
            self.weatherData = try await api.getWeather(city: "Charlotte")
            
        } catch {
            print("Error", error)
        }
    }
}


#Preview {
    ContentView()
}
