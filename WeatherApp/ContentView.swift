//
//  ContentView.swift
//  WeatherApp
//
//  Created by John Shanahan on 3/2/26.
//

import SwiftUI

struct ContentView: View {
    @State private var weatherData: WeatherData?
    
    var body: some View {
        VStack(spacing: 20) {
            ScrollView(.vertical, showsIndicators: false) {
                if let weatherData {
                    // Location Button
                    HStack{
                        Image(systemName: "location.north.circle")
                        // Button Action
                        Button("Location") {
                            
                        }.foregroundStyle(.black)
                        Spacer()
                    }.padding()
                    
                    // Weather Image
                    Image(systemName: "sun.max.fill")
                        .resizable()
                        .frame(width: 150, height: 150)
                        .foregroundStyle(.yellow)
                    
                    
                    VStack(spacing: 20){
                        // Temperature
                        Text("\(weatherData.current.currentTemperature.formatted(.number.precision(.fractionLength(0))))°")
                            .font(.system(size: 45, weight: .bold))
                            .padding(.leading)
                        // General weather
                        Text("\(weatherData.current.cloudCover.description) cloud cover")
                            .font(.system(size: 20, weight: .bold))
                            .padding(-10)
                        // High and Low
                        Text("H: L:")
                            .font(.system(size: 20, weight: .bold))
                            .padding(-10)
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
                        Text("\(weatherData.current.windSpeed.formatted(.number.precision(.fractionLength(0)))) km/h")
                            .padding(.trailing, 30)
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
                            Text("\(weatherData.hourly.timeHourly)")
                                .foregroundColor(.white)
                                .padding(.leading, 120)
                        }.padding(.bottom)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 20) {
                                ForEach(0..<12) { x in
                                    VStack(spacing: 8) {
                                        Text("AM")
                                            .font(.system(size: 20))
                                        Image(systemName: "sun.max.fill")
                                            .resizable()
                                            .frame(width: 45, height: 45)
                                            .foregroundStyle(.yellow)
                                        Text("30°")
                                            .font(.system(size: 20))
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
                    
                    
                    VStack(spacing: 12) {
                        HStack(){
                            Text("Next Forecast")
                                .font(.title3)
                            Spacer()
                        }
                        
                        ForEach(0..<7) { x in
                            HStack {
                                Text("Monday")
                                Image(systemName: "sun.max.fill")
                                    .foregroundStyle(.yellow)
                                Text("H: 78°  L: 62°")
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
            let (lat, lon) = try await api.getLatitudeAndLongitude(city: "New York")
            
            print("Latitude:", lat)
            print("Longitude:", lon)
            self.weatherData = try await api.getWeather(city: "New York")
            
        } catch {
            print("Error", error)
        }
    }
}


#Preview {
    ContentView()
}
