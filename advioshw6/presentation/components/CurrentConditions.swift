//
//  CurrentConditions.swift
//  advioshw6
//
//  Created by Dias Jakupov on 09.04.2025.
//

import SwiftUI



struct CurrentConditionsView: View {
    let weather: CurrentWeather
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Feels like \(weather.feelsLike)°")
                    .foregroundColor(.white)
                
                Text("Wind: \(weather.windSpeed) mph")
                    .foregroundColor(.white.opacity(0.8))
                    .font(.subheadline)
                
                Text("Humidity: \(weather.humidity)%")
                    .foregroundColor(.white.opacity(0.8))
                    .font(.subheadline)
            }
            
            Spacer()
                        
            AsyncImage(url: URL(string:"https://openweathermap.org/img/wn/\(weather.icon)@2x.png")) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: 50, height: 50)
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                case .failure:
                    Image(systemName: "exclamationmark.triangle")
                        .frame(width: 50, height: 50)
                        .foregroundColor(.white)
                @unknown default:
                    EmptyView()
                }
            }
        }
    }
}

