//
//  formatters.swift
//  GoodWeather
//
//  Created by Łukasz Andrzejewski on 30/05/2023.
//

import Foundation

func formatTemperature(_ value: Double) -> String {
    "\(Int(value))°"
}

func formatPressure(_ value: Double) -> String {
    "\(Int(value))hPa"
}

func formatDate(_ date: Date, dateFormat: String = "EE") -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = dateFormat
    return formatter.string(from: date)
}
