//
//  NetworkService.swift
//  advioshw6
//
//  Created by Dias Jakupov on 10.04.2025.
//

import SwiftUI

protocol NetworkService {
    func fetch<T: Decodable>(from endpoint: String) async throws -> T
}
