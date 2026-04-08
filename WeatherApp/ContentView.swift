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
    }
}

#Preview {
    ContentView()
}
