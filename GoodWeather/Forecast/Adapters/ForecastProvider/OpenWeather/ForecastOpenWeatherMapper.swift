//
//  mappers.swift
//  GoodWeather
//
//  Created by Łukasz Andrzejewski on 31/05/2023.
//

import Foundation

func toDomain(dayForecastDto: DayForecastDto) -> DayForecast {
    let date = Date(timeIntervalSince1970: dayForecastDto.date)
    let icon = dayForecastDto.weather.first?.icon ?? ""
    let description = dayForecastDto.weather.first?.description ?? ""
    let temperature = dayForecastDto.temperature.day
    let pressure = dayForecastDto.pressure
    return DayForecast(date: date, icon: icon, description: description, temperature: temperature, pressure: pressure)
}
