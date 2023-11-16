//
//  DayForecastDto.swift
//  GoodWeather
//
//  Created by Łukasz Andrzejewski on 30/05/2023.
//

import Foundation

struct DayForecastDto: Decodable {
    
    let date: Double
    let temperature: TemperatureDto
    let pressure: Double
    let weather: [WeatherDto]
        
    enum CodingKeys: String, CodingKey {
        
        case date = "dt"
        case temperature = "temp"
        case pressure
        case weather
        
    }
    
}
