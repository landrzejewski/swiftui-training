//
//  URLSessionForecastProvider.swift
//  GoodWeather
//
//  Created by Łukasz Andrzejewski on 30/05/2023.
//

import Foundation
import Combine

final class URLSessionForecastProvider: ForecastProvider {
    
    private let providerUrl = "https://api.openweathermap.org/data/2.5/forecast/daily?cnt=7&units=metric&APPID=b933866e6489f58987b2898c89f542b8"

    func getForecast(for city: String) -> AnyPublisher<Forecast, ForecastProviderError> {
        return getForecast(requestURL: "\(providerUrl)&q=\(city)")
    }
    
    func getForecast(for location: (Double, Double)) -> AnyPublisher<Forecast, ForecastProviderError> {
        return getForecast(requestURL: "\(providerUrl)&lon=\(location.0)&lat=\(location.1)")
    }
    
    private func getForecast(requestURL: String) -> AnyPublisher<Forecast, ForecastProviderError> {
        return URLSession.shared.request(for: requestURL)
            .mapError { ForecastProviderError.failed($0.localizedDescription) }
            .map { (dto: ForecastDto) in Forecast(city: dto.city.name, weather: dto.forecast.map(toDomain)) }
            .eraseToAnyPublisher()
    }
    
}
