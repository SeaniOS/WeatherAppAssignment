//
//  CityView.swift
//  WeatherApp
//
//  Created by DO HOANG SON on 18/12/25.
//

import SwiftUI

struct CityView<ViewModel: CityViewModel>: View {
    /// iOS14 for @StateObject
    @StateObject private var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
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
            .navigationBarTitle(viewModel.city.displayedName)
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
            Text("\(viewModel.currentWeather.humidity)%")
        }
    }
    
    @ViewBuilder
    private var imageView: some View {
        if let image = viewModel.uiImage {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .frame(width: 72, height: 72)
                .clipShape(RoundedRectangle(cornerRadius: 12.0))
        }
    }
    
    @ViewBuilder
    private var weatherDescriptionView: some View {
        Text(viewModel.currentWeather.description)
    }
    
    private var temperatureView: some View {
        HStack {
            Text("Temperature")
                .bold()
            Text("\(viewModel.currentWeather.temperature)°C")
        }
    }
}

#Preview {
    let city = City(name: "Hanoi", country: "Vietnam", latitude: "21.033", longitude: "105.850")
    let vm = DependencyInjectionHandler().makeCityViewModel(city: city)
    CityView(viewModel: vm)
}

