//
//  ForecastRepository.swift
//  GoodWeather
//
//  Created by Łukasz Andrzejewski on 31/05/2023.
//

import Foundation

protocol ForecastRepository {
    
    func save(forecast: Forecast) throws
    
    func deleteAll() throws
    
    func get(by city: String, callback: @escaping (Result<Forecast, ForecastRepositoryError>) -> ()) throws
    
}
