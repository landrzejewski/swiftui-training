//
//  LocationProvider.swift
//  GoodWeather
//
//  Created by Łukasz Andrzejewski on 31/05/2023.
//

import Foundation
import Combine

protocol LocationProvider {
    
    func refreshLocation()
    
    var location: AnyPublisher<(Double, Double), Never> { get }
    
}
