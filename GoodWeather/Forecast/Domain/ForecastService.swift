//
//  ForecastService.swift
//  GoodWeather
//
//  Created by Łukasz Andrzejewski on 31/05/2023.
//

import Foundation
import Combine

final class ForecastService {
    
    private let forecastProvider: ForecastProvider
    private let forecastRepository: ForecastRepository
    private var subscriptions = Set<AnyCancellable>()
    
    init(forecastProvider: ForecastProvider, forecastRepository: ForecastRepository) {
        self.forecastProvider = forecastProvider
        self.forecastRepository = forecastRepository
    }
    
    func getForecast(for city: String) -> AnyPublisher<Forecast, ForecastProviderError> {
        let respose = PassthroughSubject<Forecast, ForecastProviderError>()
        try? forecastRepository.get(by: city) { result in
            if case let .success(forecast) = result {
                respose.send(forecast)
            }
        }
        forecastProvider.getForecast(for: city)
            .sink {
                if case .failure = $0 {
                    respose.send(completion: $0)
                }
            }
            receiveValue: { [unowned self] forecast in
                try? forecastRepository.deleteAll()
                try? forecastRepository.save(forecast: forecast)
                respose.send(forecast)
                subscriptions.removeAll()
            }
            .store(in: &subscriptions)
        return respose.eraseToAnyPublisher()
    }
    
    func getForecast(for location: (Double, Double)) -> AnyPublisher<Forecast, ForecastProviderError> {
        forecastProvider.getForecast(for: location)
    }
    
}
