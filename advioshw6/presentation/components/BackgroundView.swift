//
//  BackgroundView.swift
//  advioshw6
//
//  Created by Dias Jakupov on 09.04.2025.
//


import SwiftUI

struct BackgroundView: View {
    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: [Color.blue.opacity(0.6), Color.blue.opacity(0.2)]),
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()
    }
}
