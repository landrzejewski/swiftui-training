//
//  ForecastDto.swift
//  GoodWeather
//
//  Created by Łukasz Andrzejewski on 30/05/2023.
//

import Foundation

struct ForecastDto: Decodable {
    
    let city: CityDto
    let forecast: [DayForecastDto]
    
    enum CodingKeys: String, CodingKey {
        
        case city
        case forecast = "list"
        
    }
    
}
