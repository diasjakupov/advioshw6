//
//  WeatherScreen.swift
//  advioshw6
//
//  Created by Dias Jakupov on 09.04.2025.
//

import SwiftUI

struct WeatherScreen: View {
    @StateObject private var viewModel = WeatherViewModel()
    @State private var showingCityInput = false
        
        var body: some View {
            NavigationStack {
                ZStack {
                    BackgroundView()
                    
                    VStack(spacing: 0) {
                        if showingCityInput {
                            CityInputSelectionView(viewModel: viewModel)
                                .padding(.vertical, 8)
                                .background(Color.black.opacity(0.3))
                                .transition(.move(edge: .top).combined(with: .opacity))
                        }
                        
                        ScrollView {
                            VStack(spacing: 16) {
                                WeatherHeaderView(viewModel: viewModel)
                                
                                ForEach(viewModel.weatherComponents) { component in
                                    WeatherComponentContainerView(component: component, retry: {
                                        viewModel.refreshComponent(component.type)
                                    })
                                }
                            }
                            .padding()
                        }
                        .refreshable {
                            viewModel.loadAllData(forceRefresh: true)
                        }
                    }
                }
                .navigationTitle("")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Button(action: {
                            withAnimation {
                                showingCityInput.toggle()
                            }
                        }) {
                            HStack {
                                Text(viewModel.selectedCity)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                Image(systemName: showingCityInput ? "chevron.up" : "chevron.down")
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        RefreshButton(isRefreshing: viewModel.isRefreshing) {
                            viewModel.loadAllData(forceRefresh: true)
                        }
                    }
                }
                .onAppear {
                    viewModel.loadAllData(forceRefresh: false)
                }
                .onTapGesture {
                    if showingCityInput {
                        withAnimation {
                            showingCityInput = false
                        }
                    }
                }
            }
        }
}
