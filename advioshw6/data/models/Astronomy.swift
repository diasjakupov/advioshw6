//
//  Astronomy.swift
//  advioshw6
//
//  Created by Dias Jakupov on 10.04.2025.
//

struct AstronomyResponse: Decodable {
    let astronomy: Astronomy
}

struct Astronomy: Decodable {
    let astro: Astro
}

struct Astro: Decodable {
    let sunrise: String
    let sunset: String
    let moonrise: String
    let moonset: String
    let moonPhase: String
    let moonIllumination: Int
    let isMoonUp: Int
    let isSunUp: Int

    enum CodingKeys: String, CodingKey {
        case sunrise, sunset, moonrise, moonset
        case moonPhase = "moon_phase"
        case moonIllumination = "moon_illumination"
        case isMoonUp = "is_moon_up"
        case isSunUp = "is_sun_up"
    }
}

extension Astro {
    func toDomainModel() -> AstronomyInfo {
        AstronomyInfo(
            sunrise: self.sunrise,
            sunset: self.sunset,
            moonPhase: self.moonPhase,
            isSunUp: self.isSunUp == 1,
            isMoonUp: self.isMoonUp == 1
        )
    }
}
