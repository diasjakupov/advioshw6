//
//  CitySelectionView.swift
//  advioshw6
//
//  Created by Dias Jakupov on 09.04.2025.
//

import SwiftUI

struct CityInputSelectionView: View {
    @ObservedObject var viewModel: WeatherViewModel
    @State private var isEditing = false
    @State private var inputText: String = ""
    

    var body: some View {
        VStack {
            HStack {
                TextField("Enter city name", text: $inputText)
                    .padding(8)
                    .background(Color.white.opacity(0.2))
                    .cornerRadius(8)
                    .padding(.trailing, 8)
                    .foregroundColor(.white)
                    .onAppear {
                        inputText = viewModel.selectedCity
                    }
                    .onChange(of: viewModel.selectedCity) { old, newValue in
                        if !isEditing {
                            inputText = newValue
                        }
                    }
                    .onTapGesture {
                        isEditing = true
                    }
                
                Button(action: {
                    if !inputText.isEmpty {
                        viewModel.selectedCity = inputText
                        isEditing = false
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
                }) {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.white)
                        .padding(8)
                        .background(Color.blue)
                        .cornerRadius(8)
                }
            }
            .frame(height: 40)
        }
    }
}
