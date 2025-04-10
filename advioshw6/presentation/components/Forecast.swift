//
//  Forecast.swift
//  advioshw6
//
//  Created by Dias Jakupov on 09.04.2025.
//

import SwiftUI

struct ForecastView: View {
    let forecast: [DayForecast]
    
    var body: some View {
        VStack(spacing: 12) {
            ForEach(forecast) { day in
                ForecastDayRow(day: day)
                
                if day.id != forecast.last?.id {
                    Divider()
                        .background(Color.white.opacity(0.3))
                }
            }
        }
    }
}

struct ForecastDayRow: View {
    let day: DayForecast
    
    var body: some View {
        HStack {
            Text(day.day)
                .frame(width: 100, alignment: .leading)
                .foregroundColor(.white)
                        
            AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(day.icon)@2x.png")) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: 25, height: 25)
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 35, height: 35)
                case .failure:
                    Image(systemName: "exclamationmark.triangle")
                        .frame(width: 35, height: 35)
                        .foregroundColor(.white)
                @unknown default:
                    EmptyView()
                }
            }
            
            Spacer()
            
            Text("H: \(day.high)°")
                .foregroundColor(.white)
            
            Text("L: \(day.low)°")
                .foregroundColor(.white.opacity(0.7))
                .frame(width: 50, alignment: .trailing)
        }
    }
}
