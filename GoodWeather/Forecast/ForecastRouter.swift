//
//  ForecastRouter.swift
//  GoodWeather
//
//  Created by Łukasz Andrzejewski on 30/05/2023.
//

import Foundation

final class ForecastRouter: ObservableObject {
    
    @Published
    var route = ForecastRoute.forecast
    
}
