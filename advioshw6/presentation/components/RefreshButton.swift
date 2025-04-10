//
//  RefreshButton.swift
//  advioshw6
//
//  Created by Dias Jakupov on 09.04.2025.
//

import SwiftUI

struct RefreshButton: View {
    let isRefreshing: Bool
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: "arrow.clockwise")
                .foregroundColor(.white)
        }
        .disabled(isRefreshing)
    }
}
