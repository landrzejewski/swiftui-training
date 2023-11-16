//
//  Container+ext.swift
//  GoodWeather
//
//  Created by Łukasz Andrzejewski on 30/05/2023.
//

import Factory

extension Container {
    
    var forecastProvider: Factory<ForecastProvider> {
        self { URLSessionForecastProvider() }.singleton
    }
    
    var locationProvider: Factory<LocationProvider> {
        self { CoreLocationProvider() }.singleton
    }
    
    var forecastRepository: Factory<ForecastRepository> {
        self { try! SqlForecastRepository() }.singleton
    }
    
    var forecastService: Factory<ForecastService> {
        self { ForecastService(forecastProvider: self.forecastProvider(), forecastRepository: self.forecastRepository()) }.singleton
    }
    
    var forecastViewModel: Factory<ForecastViewModel> {
        self { ForecastViewModel(forecastService: self.forecastService(), locationProvider: self.locationProvider()) }.singleton
    }
    
    var profileViewModel: Factory<ProfileViewModel> {
        self { ProfileViewModel() }.singleton
    }
    
    var foodListViewModel: Factory<FoodListViewModel> {
        self { FoodListViewModel() }.singleton
    }
    
    var orderViewModel: Factory<OrderViewModel> {
        self { OrderViewModel() }.singleton
    }
    
}
