//
//  DefaultNetworkService.swift
//  advioshw6
//
//  Created by Dias Jakupov on 10.04.2025.
//

import SwiftUI

class DefaultNetworkService: NetworkService {
    func fetch<T: Decodable>(from endpoint: String) async throws -> T {
        guard let url = URL(string: endpoint) else {
            throw WeatherError.invalidURL
        }
                
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw WeatherError.serverError((response as? HTTPURLResponse)?.statusCode ?? -1)
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            print("Network service: \(error) \n \(url)")
            throw WeatherError.decodingError(error)
        }
    }
}
