//
//  CityView.swift
//  WeatherApp
//
//  Created by DO HOANG SON on 18/12/25.
//

import SwiftUI

struct CityView<ViewModel: CityViewModel>: View {
    /// iOS14 for @StateObject
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        ZStack {
            AppConstants.ThemeColor.pantoneCloudDancerColor
                .ignoresSafeArea()
            
            VStack(alignment: .center, spacing: 10) {
                imageView
                weatherDescriptionView
                
                VStack(alignment: .leading, spacing: 10) {
                    temperatureView
                    humidityView
                }
            }
            .navigationBarTitle("Hanoi")
            .onAppear(perform: viewModel.onAppear)
        }
    }
}

// MARK: - Component Views
extension CityView {
    private var humidityView: some View {
        HStack {
            Text("Humidity")
                .bold()
            Text("83%")
        }
    }
    
    @ViewBuilder
    private var imageView: some View {
        if let image = viewModel.uiImage {
            Image(uiImage: image)
        }
    }
    
    private var weatherDescriptionView: some View {
        Text("Partly Cloudy")
    }
    
    private var temperatureView: some View {
        HStack {
            Text("Temperature")
                .bold()
            Text("21°C")
        }
    }
}

#Preview {
    CityView(viewModel: DefaultCityViewModel())
}
