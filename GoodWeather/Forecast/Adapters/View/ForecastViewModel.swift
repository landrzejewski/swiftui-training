//
//  ForecastViewModel.swift
//  GoodWeather
//
//  Created by Łukasz Andrzejewski on 30/05/2023.
//

import Foundation
import Combine

final class ForecastViewModel: ObservableObject {
    
    @Published
    var city = ""
    @Published
    var currentForecast: DayForecastViewModel?
    @Published
    var nextDaysForecast: [DayForecastViewModel] = []
    @Published
    var errors = false
    
    private let forecastService: ForecastService
    private let locationProvider: LocationProvider
    private var subscriptions = Set<AnyCancellable>()
    private var locationSubscription: AnyCancellable?
    
    init(forecastService: ForecastService, locationProvider: LocationProvider) {
        self.forecastService = forecastService
        self.locationProvider = locationProvider
        locationSubscription = locationProvider.location.sink { [unowned self] location in
            onForecastRefreshed(forecast: forecastService.getForecast(for: location))
        }
    }
    
    func refreshForecast() {
        if !city.isEmpty {
            refreshForecast(for: city)
        } else {
            refreshForecastForCurrentLocation()
        }
    }
    
    func refreshForecast(for city: String) {
        onForecastRefreshed(forecast: forecastService.getForecast(for: city))
    }
    
    func refreshForecastForCurrentLocation() {
        locationProvider.refreshLocation()
    }
    
    private func onForecastRefreshed(forecast: AnyPublisher<Forecast, ForecastProviderError>) {
        forecast.receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {
                switch $0 {
                case .finished:
                    self.subscriptions.removeAll()
                case .failure(_):
                    self.errors = true
                }
            }) {
                self.errors = false
                self.showForecast($0)
            }
            .store(in: &subscriptions)
    }
    
    func showForecast(_ forecast: Forecast) {
        city = forecast.city
        currentForecast = toViewModel(forecast.weather.first!)
        nextDaysForecast = forecast.weather.dropLast().map(toViewModel)
    }
    
}
