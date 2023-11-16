//
//  ForecastView.swift
//  GoodWeather
//
//  Created by Łukasz Andrzejewski on 30/05/2023.
//

import SwiftUI
import Factory

struct ForecastView: View {
    
    @ObservedObject
    var viewModel: ForecastViewModel
    @State
    private var showSettings = false
    @EnvironmentObject
    private var router: ForecastRouter
    @AppStorage("city")
    private var city = ""
    @Environment(\.scenePhase)
    private var scenePhase: ScenePhase
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.mainColor, .black], startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack {
                HStack {
                    Image(systemName: "location")
                        .templateStyle(width: 20, height: 20)
                        .onTapGesture { viewModel.refreshForecastForCurrentLocation() }
                        .accessibility(identifier: "location")
                    Spacer()
                    Image(systemName: "slider.horizontal.3")
                        .templateStyle(width: 20, height: 20)
                        .onTapGesture { showSettings = true }
                        .accessibility(identifier: "settings")
                }
                .padding()
                Text(viewModel.city)
                    .defaultStyle(size: 32)
                    .accessibility(identifier: "city")
                Spacer()
                if let currentForecast = viewModel.currentForecast {
                    Image(systemName: currentForecast.icon)
                        .iconStyle(width: 200, height: 200)
                    Text(currentForecast.description)
                        .defaultStyle(size: 32)
                    HStack(spacing: 32.0) {
                        Text(currentForecast.temperature)
                            .defaultStyle(size: 16)
                        Text(currentForecast.pressure)
                            .defaultStyle(size: 16)
                    }
                }
                Spacer()
                HStack {
                    ScrollView(.horizontal) {
                        HStack(spacing: 16.0) {
                            ForEach(viewModel.nextDaysForecast, id: \.date) {
                                DayForecastView(viewModel: $0)
                            }
                        }
                    }
                    .padding(.all, 32)
                }
            }
            if viewModel.errors {
                VStack {
                    Spacer()
                    Text("Refresh forecast failed")
                        .frame(width: UIScreen.main.bounds.width)
                        .padding(.top, 8)
                        .background(.red)
                }
            }
        }
        .sheet(isPresented: $showSettings) { ForecastSettingsView() }
        .onAppear { viewModel.city = city }
        .onChange(of: city, perform: viewModel.refreshForecast(for:))
        .onChange(of: scenePhase) { phase in
            if phase == .active {
                viewModel.refreshForecast()
            }
        }
    }
    
}

struct ForecastView_Previews: PreviewProvider {
    
    static var previews: some View {
        ForecastView(viewModel: Container.shared.forecastViewModel())
    }
    
}
