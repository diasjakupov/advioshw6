//
//  AirQuality.swift
//  advioshw6
//
//  Created by Dias Jakupov on 09.04.2025.
//

import SwiftUI

struct AirQualityView: View {
    let airQuality: AirQuality
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Air Quality Index: \(airQuality.index)")
                    .font(.title3)
                    .foregroundColor(.white)
                
                Spacer()
                
                AirQualityBadge(quality: airQuality.quality)
            }
            
            Divider()
                .background(Color.white.opacity(0.3))
            
            Text("Pollutants")
                .font(.subheadline)
                .foregroundColor(.white)
            
            PollutantsListView(pollutants: airQuality.pollutants)
        }
    }
}

struct AirQualityBadge: View {
    let quality: String
    
    var body: some View {
        Text(quality)
            .font(.headline)
            .padding(.horizontal, 12)
            .padding(.vertical, 4)
            .background(WeatherHelpers.airQualityColor(for: quality))
            .cornerRadius(12)
            .foregroundColor(.white)
    }
}

struct PollutantsListView: View {
    let pollutants: [String: Int]
    
    var body: some View {
        ForEach(Array(pollutants.keys.sorted()), id: \.self) { key in
            if let value = pollutants[key] {
                HStack {
                    Text(key)
                        .foregroundColor(.white.opacity(0.8))
                    
                    Spacer()
                    
                    Text("\(value) μg/m³")
                        .foregroundColor(.white)
                }
                .font(.caption)
            }
        }
    }
}
