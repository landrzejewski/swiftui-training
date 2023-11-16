//
//  FakeLocationProvider.swift
//  GoodWeather
//
//  Created by Łukasz Andrzejewski on 31/05/2023.
//

import Foundation
import Combine

final class FakeLocationProvider: LocationProvider {
    
    private let fakeLocation: (Double, Double)
    private let subject = PassthroughSubject<(Double, Double), Never>()
    
    func refreshLocation() {
        subject.send(fakeLocation)
    }
    
    var location: AnyPublisher<(Double, Double), Never>
    
    init(fakeLocation: (Double, Double) = (21.017532, 52.237049)) {
        self.fakeLocation = fakeLocation
        location = subject.eraseToAnyPublisher()
    }
    
}
