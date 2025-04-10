//
//  WeatherMp.swift
//  advioshw6
//
//  Created by Dias Jakupov on 09.04.2025.
//

import SwiftUI

struct AstronomyView: View {
    let info: AstronomyInfo

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 6) {
                Text("Sunrise: \(info.sunrise)")
                    .foregroundColor(.white)

                Text("Sunset: \(info.sunset)")
                    .foregroundColor(.white)

                Text("Moon Phase: \(info.moonPhase)")
                    .foregroundColor(.white)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 8) {
                Label(info.isSunUp ? "Sun is up" : "Sun is down",
                      systemImage: info.isSunUp ? "sun.max.fill" : "moon.fill")
                    .foregroundColor(info.isSunUp ? .yellow : .gray)
                    .font(.headline)

                Label(info.isMoonUp ? "Moon is up" : "Moon is down",
                      systemImage: info.isMoonUp ? "moon.stars.fill" : "sun.max")
                    .foregroundColor(info.isMoonUp ? .blue : .gray)
                    .font(.headline)
            }
        }
    }
}

