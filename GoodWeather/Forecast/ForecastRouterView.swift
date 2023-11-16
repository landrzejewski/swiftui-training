//
//  ForecastRouterView.swift
//  GoodWeather
//
//  Created by Łukasz Andrzejewski on 30/05/2023.
//

import SwiftUI
import Factory

struct ForecastRouterView: View {
    
    @Injected(\.forecastViewModel)
    private var forecastViewModel: ForecastViewModel
    @EnvironmentObject
    private var router: ForecastRouter
    
    var body: some View {
        switch router.route {
        case .forecast:
            ForecastView(viewModel: forecastViewModel)
        case .forecastDetalis(let viewModel):
            ForecastDetailsView(viewModel: viewModel)
        }
    }
}

struct RouterView_Previews: PreviewProvider {
    static var previews: some View {
        ForecastRouterView()
    }
}
