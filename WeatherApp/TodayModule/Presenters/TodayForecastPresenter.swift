//
//  TodayForecastPresenter.swift
//  WeatherApp
//
//  Created by Тимофей Лукашевич on 18.09.20.
//  Copyright © 2020 Тимофей Лукашевич. All rights reserved.
//

import UIKit


protocol TodayForecastViewProtocol: class {
    func succes()
    func failure(error: Error)
    var presenter: TodayForecastPresenterProtocol! {get set}
    var wetherImage: UIImageView! {get set}
    var locationTitle: UILabel {get set}
    var wetherTitle: UILabel {get set}
    var pressureLabel: UILabel {get set}
    var humidityLabel: UILabel {get set}
    var cLabel: UILabel {get set}
    var windSpeedLabel: UILabel {get set}
    var SELabel: UILabel {get set}
}


// MARK: - presenter for today forecast
protocol TodayForecastPresenterProtocol: class {
    init(view: TodayForecastViewProtocol, networkService: TodayNetworkServiceProtocole)
    func getForecast()
    var forecast: CurrentWeatherData? { get set }
}


class TodayForecastPresenter: TodayForecastPresenterProtocol {
    
    weak var view: TodayForecastViewProtocol?
    var networkService: TodayNetworkServiceProtocole?
    var forecast: CurrentWeatherData?
    
    required init(view: TodayForecastViewProtocol, networkService: TodayNetworkServiceProtocole) {
        self.view = view
        view.presenter = self
        self.networkService = networkService
        getForecast()
    }
    
    func getForecast() {
        networkService!.getCurrentWeather{ [weak self] result in
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
