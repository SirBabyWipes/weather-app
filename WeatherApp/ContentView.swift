//
//  ContentView.swift
//  WeatherApp
//
//  Created by John Shanahan on 3/2/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 20) {
            
            // Location Button
            HStack{
                Image(systemName: "location.north.circle")
                // Button Action
                Button("Location") {
                    
                }.foregroundStyle(.black)
                Spacer()
            }.padding(.bottom).padding(.horizontal)
            
            // Weather Image
            Image(systemName: "sun.max.fill")
                .resizable()
                .frame(width: 150, height: 150)
                .foregroundStyle(.yellow)

            
            Divider()
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(0..<12) { x in
                        VStack(spacing: 8) {
                            Text("3PM")
                                .font(.caption)
                            Text("72°")
                        }
                    }
                }
                
            }
            
            Divider()
                .padding(.horizontal)
            
            VStack(spacing: 12) {
                ForEach(0..<7) { x in
                    HStack {
                        Text("Monday")
                        Image(systemName: "sun.max.fill")
                            .foregroundStyle(.yellow)
                        Text("H: 78°  L: 62°")
                    }
                    .padding(.horizontal)
                }
            }
            
            Spacer()
                
        }
        .padding()
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
    }


#Preview {
    ContentView()
}
