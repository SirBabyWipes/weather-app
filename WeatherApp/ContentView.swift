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
            ScrollView(.vertical, showsIndicators: false) {
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
                    Text("30°")
                        .font(.system(size: 45, weight: .bold))
                        .padding(.leading)
                    // General weather
                    Text("Sunny")
                        .font(.system(size: 20, weight: .bold))
                        .padding(-10)
                    // High and Low
                    Text("H:78 L:62")
                        .font(.system(size: 20, weight: .bold))
                        .padding(-10)
                }.padding()
                
                
                
                // First Card
                HStack(){
                    Image(systemName: "drop")
                    Text("20%")
                        .padding(.trailing, 30)
                    
                    Image(systemName: "humidity")
                    Text("50%")
                        .padding(.trailing, 30)
                    
                    Image(systemName: "wind")
                    Text("25 km/h")
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
                        Text("Date")
                            .foregroundColor(.white)
                            .padding(.leading, 120)
                    }.padding(.bottom)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(0..<12) { x in
                                VStack(spacing: 8) {
                                    Text("3PM")
                                        .font(.system(size: 20))
                                    Image(systemName: "sun.max.fill")
                                        .resizable()
                                        .frame(width: 45, height: 45)
                                        .foregroundStyle(.yellow)
                                    Text("72°")
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
                    
            }
        }
        .padding()
        .background(.cyan)
        .ignoresSafeArea()
        .task {
                   await fetchWeather()
               }
    }
    func fetchWeather() async {
            let api = WeatherAPI()

            do {
                let _ = try await api.getWeather(city: "Charlotte")
            } catch {
                print("Error", error)
            }
        }
    }


#Preview {
    ContentView()
}
