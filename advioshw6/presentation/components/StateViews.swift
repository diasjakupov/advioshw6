//
//  StateViews.swift
//  advioshw6
//
//  Created by Dias Jakupov on 09.04.2025.
//

import SwiftUI

struct NotLoadedView: View {
    var body: some View {
        Text("Tap refresh to load data")
            .foregroundColor(.white.opacity(0.7))
            .frame(maxWidth: .infinity, alignment: .center)
            .padding()
    }
}

struct LoadingView: View {
    let progress: Float
    
    var body: some View {
        VStack {
            ProgressView(value: progress)
                .progressViewStyle(LinearProgressViewStyle(tint: .white))
                .padding(.bottom, 4)
            
            Text("\(Int(progress * 100))% Complete")
                .font(.caption)
                .foregroundColor(.white.opacity(0.7))
        }
        .padding()
    }
}

struct ErrorView: View {
    let errorMessage: String?
    let action: () -> Void

    
    var body: some View {
        VStack {
            Image(systemName: "exclamationmark.triangle")
                .font(.title)
                .foregroundColor(.yellow)
                .padding(.bottom, 4)
            
            Text(errorMessage ?? "An error occurred")
                .foregroundColor(.white)
            
            Button("Retry") {
                action()
            }
            .padding(.top, 8)
            .foregroundColor(.white)
            .padding(.horizontal, 16)
            .padding(.vertical, 6)
            .background(Color.blue.opacity(0.3))
            .cornerRadius(8)
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
}

