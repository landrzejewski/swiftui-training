//
//  DayForecastView.swift
//  GoodWeather
//
//  Created by Łukasz Andrzejewski on 30/05/2023.
//

import SwiftUI

struct DayForecastView: View {
   
    var viewModel: DayForecastViewModel
    
    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: viewModel.icon)
                .iconStyle()
            Text(viewModel.temperature)
                .defaultStyle()
            Text(viewModel.date)
                .defaultStyle(size: 14)
        }
    }
}

struct DayForecastView_Previews: PreviewProvider {
    static var previews: some View {
        DayForecastView(viewModel: DayForecastViewModel(date: "Pn", icon: "sun.max.fill", description: "", temperature: "18°", pressure: ""))
    }
}
