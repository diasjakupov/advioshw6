//
//  AlertsResponse.swift
//  advioshw6
//
//  Created by Dias Jakupov on 10.04.2025.
//

import SwiftUI

struct AlertsResponse: Decodable {
    struct Location: Decodable {
        let name: String
        let region: String
        let country: String
        let lat: Double
        let lon: Double
        let tz_id: String
        let localtime_epoch: Int
        let localtime: String
    }
    
    struct Alert: Decodable {
        let headline: String
        let severity: String
        let desc: String
    }
    
    struct Alerts: Decodable {
        let alert: [Alert]
    }

    let location: Location
    let alerts: Alerts
}
