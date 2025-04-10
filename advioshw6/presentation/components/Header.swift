//
//  Header.swift
//  advioshw6
//
//  Created by Dias Jakupov on 09.04.2025.
//

import SwiftUI

struct WeatherHeaderView: View {
    @ObservedObject var viewModel: WeatherViewModel
    
    var body: some View {
        VStack(spacing: 8) {
            if let currentComponent = viewModel.weatherComponents.first(where: { $0.type == .currentConditions }),
               case .loaded = currentComponent.state,
               let currentWeather = currentComponent.data as? CurrentWeather {
                Text("\(currentWeather.temperature)°")
                    .font(.system(size: 80, weight: .thin))
                    .foregroundColor(.white)
                
                Text(currentWeather.condition)
                    .font(.title3)
                    .foregroundColor(.white)
                
                Text("H: \(currentWeather.highTemp)°  L: \(currentWeather.lowTemp)°")
                    .font(.headline)
                    .foregroundColor(.white)
            } else {
                Text("--°")
                    .font(.system(size: 80, weight: .thin))
                    .foregroundColor(.white)
                
                Text("Loading...")
                    .font(.title3)
                    .foregroundColor(.white.opacity(0.8))
            }
        }
        .padding(.top, 20)
        .padding(.bottom, 20)
    }
}
