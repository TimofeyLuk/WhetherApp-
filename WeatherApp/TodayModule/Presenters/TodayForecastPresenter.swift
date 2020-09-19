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
    func ImageSucces(image: UIImage?)
    func ImageFailure(error: Error)
    var presenter: TodayForecastPresenterProtocol! {get set}
}


// MARK: - presenter for today forecast
protocol TodayForecastPresenterProtocol: class {
    init(view: TodayForecastViewProtocol, networkService: TodayNetworkServiceProtocole)
    func getForecast()
    var forecast: CurrentWeatherData? { get set }
}


class TodayForecastPresenter: TodayForecastPresenterProtocol, UpdateDelegateProtocol{
    
    weak var view: TodayForecastViewProtocol?
    var networkService: TodayNetworkServiceProtocole?
    var forecast: CurrentWeatherData?
    
    required init(view: TodayForecastViewProtocol, networkService: TodayNetworkServiceProtocole) {
        self.view = view
        view.presenter = self
        self.networkService = networkService
        self.networkService?.currentLocation.delegate = self
        getForecast()
    }
    
    func getForecast() {
        networkService!.getCurrentWeather{ [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let forecast):
                    self.forecast = forecast
                    self.view?.succes()
                    if let image = forecast?.weather?.first?.icon {
                        self.getImage(imageIndex: image)
                    }
                case .failure(let error):
                    self.view?.failure(error: error)
                }
            }
        }
    }
    
    func getImage(imageIndex: String) {
        networkService!.getWeatheImage(imageIndex: imageIndex, completion:{ [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    self.view?.ImageSucces(image: image)
                case .failure(let error):
                    self.view?.failure(error: error)
                }
            }
        })
    }
    
    func lokationDidUpdate() {
        getForecast()
    }
    
    
}
