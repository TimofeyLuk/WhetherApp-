//
//  TodayForecastPresenter.swift
//  WeatherApp
//
//  Created by Тимофей Лукашевич on 18.09.20.
//  Copyright © 2020 Тимофей Лукашевич. All rights reserved.
//

import Foundation


protocol TodayForecastViewProtocol: class {
    func succes()
    func failure(error: Error)
}


// MARK: - presenter for today forecast
protocol TodayForecastPresenterProtocol: class {
    init(view: TodayForecastViewProtocol, networkService: TodayNetworkServiceProtocole)
    func getForecast()
    var forecast: CurrentWeatherData? { get set }
}


class TodayForecastPresenter: TodayForecastPresenterProtocol {
    
    weak var view: TodayForecastViewProtocol?
    let networkService: TodayNetworkServiceProtocole!
    var forecast: CurrentWeatherData?
    
    required init(view: TodayForecastViewProtocol, networkService: TodayNetworkServiceProtocole) {
        self.view = view
        self.networkService = networkService
        getForecast()
    }
    
    func getForecast() {
        networkService.getCurrentWeather{ [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let forecast):
                self.forecast = forecast
                self.view?.succes()
            case .failure(let error):
                self.view?.failure(error: error)
            }
        }
    }
    
    
    
    
}
