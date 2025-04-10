//
//  Alerts.swift
//  advioshw6
//
//  Created by Dias Jakupov on 09.04.2025.
//

import SwiftUI

struct AlertsView: View {
    let alerts: [WeatherAlert]
    
    var body: some View {
        if alerts.isEmpty {
            Text("No active weather alerts")
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding()
        } else {
            VStack(spacing: 12) {
                ForEach(alerts) { alert in
                    AlertRow(alert: alert)
                    
                    if alert.id != alerts.last?.id {
                        Divider()
                            .background(Color.white.opacity(0.3))
                    }
                }
            }
        }
    }
}

struct AlertRow: View {
    let alert: WeatherAlert
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: "exclamationmark.triangle.fill")
                    .foregroundColor(WeatherHelpers.alertColor(for: alert.severity))
                
                Text(alert.title)
                    .font(.headline)
                    .foregroundColor(.white)
                
                Spacer()
                
                AlertSeverityBadge(severity: alert.severity)
            }
            
            Text(alert.description)
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.8))
                .padding(.leading, 4)
        }
        .padding(.vertical, 8)
    }
}

struct AlertSeverityBadge: View {
    let severity: String
    
    var body: some View {
        Text(severity)
            .font(.caption)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(WeatherHelpers.alertColor(for: severity))
            .cornerRadius(8)
            .foregroundColor(.white)
    }
}
