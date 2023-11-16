//
//  mappers.swift
//  GoodWeather
//
//  Created by Łukasz Andrzejewski on 31/05/2023.
//

import Foundation

func toViewModel(_ dayForecast: DayForecast) -> DayForecastViewModel {
    let date = formatDate(dayForecast.date)
    let icon = mapIcon(dayForecast.icon)
    let temperature = formatTemperature(dayForecast.temperature)
    let pressure = formatPressure(dayForecast.pressure)
    return DayForecastViewModel(date: date, icon: icon, description: dayForecast.description, temperature: temperature , pressure: pressure)
}
