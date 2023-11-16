//
//  ForecastProvider.swift
//  GoodWeather
//
//  Created by Łukasz Andrzejewski on 29/05/2023.
//

import Foundation
import Combine

protocol ForecastProvider {
    
    func getForecast(for city: String) -> AnyPublisher<Forecast, ForecastProviderError>
    
    func getForecast(for location: (Double, Double)) -> AnyPublisher<Forecast, ForecastProviderError>
    
}
