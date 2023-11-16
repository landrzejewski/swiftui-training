//
//  OrderViewModel.swift
//  GoodWeather
//
//  Created by Łukasz Andrzejewski on 30/05/2023.
//

import Foundation

final class OrderViewModel: ObservableObject {
    
    @Published
    var orderEntries = [
        OrderEntryViewModel(id: 1, name: "Mega burger", price: "40 zł"),
        OrderEntryViewModel(id: 2, name: "Asparagus steak", price: "20 zł")
    ]
    @Published
    var totalPrice = "60 zł"
    
}
