//
//  AirPollutionResponse.swift
//  advioshw6
//
//  Created by Dias Jakupov on 10.04.2025.
//


struct AirPollutionResponse: Decodable {
    let coord: Coord
    let list: [PollutionData]
}


struct PollutionData: Decodable {
    let main: AQIMain
    let components: Components
    let dt: Int
}

struct AQIMain: Decodable {
    let aqi: Int
}

struct Components: Decodable {
    let co: Double
    let no: Double
    let no2: Double
    let o3: Double
    let so2: Double
    let pm2_5: Double
    let pm10: Double
    let nh3: Double
    
    enum CodingKeys: String, CodingKey {
        case co, no, no2, o3, so2, pm10, nh3
        case pm2_5 = "pm2_5"
    }
}

extension AirPollutionResponse {
    func toDomainModel() -> AirQuality? {
        guard let data = list.first else { return nil }

        let quality: String
        switch data.main.aqi {
        case 1: quality = "Good"
        case 2: quality = "Fair"
        case 3: quality = "Moderate"
        case 4: quality = "Poor"
        case 5: quality = "Very Poor"
        default: quality = "Unknown"
        }

        return AirQuality(
            index: data.main.aqi,
            quality: quality,
            pollutants: [
                "CO": Int(data.components.co.rounded()),
                "NO": Int(data.components.no.rounded()),
                "NO2": Int(data.components.no2.rounded()),
                "O3": Int(data.components.o3.rounded()),
                "SO2": Int(data.components.so2.rounded()),
                "PM2.5": Int(data.components.pm2_5.rounded()),
                "PM10": Int(data.components.pm10.rounded()),
                "NH3": Int(data.components.nh3.rounded())
            ]
        )
    }
}
