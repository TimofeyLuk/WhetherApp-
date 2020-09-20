//
//  WeekForecastPresenter.swift
//  WeatherApp
//
//  Created by Тимофей Лукашевич on 20.09.20.
//  Copyright © 2020 Тимофей Лукашевич. All rights reserved.
//

import UIKit


protocol WeekForecastViewProtocol: class {
    func succes()
    func failure(error: Error)
    func ImageSucces(image: UIImage?)
    func ImageFailure(error: Error)
    var presenter: WeekForecastPresenterProtocol! {get set}
}


// MARK: - presenter for week forecast
protocol WeekForecastPresenterProtocol: class {
    init(view: WeekForecastViewProtocol, networkService: WeekNetworkServiceProtocol)
    func getForecast()
    var forecast: Forecast? { get set }
}


class WeekForecastPresenter: WeekForecastPresenterProtocol, UpdateDelegateProtocol {

    weak var view: WeekForecastViewProtocol?
    var networkService: WeekNetworkServiceProtocol?
    var forecast: Forecast?
    
    required init(view: WeekForecastViewProtocol, networkService: WeekNetworkServiceProtocol) {
        self.view = view
        view.presenter = self
        self.networkService = networkService
        self.networkService?.currentLocation.delegate = self
        getForecast()
    }
    
    func getForecast() {
        networkService?.getWeekWeather(completion: ) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                    case .success(let forecast):
                        self.forecast = Forecast(forecast: forecast!)
                        self.view?.succes()
                    case .failure(let error):
                        self.view?.failure(error: error)
                }
            }
        }
    }
    
    func lokationDidUpdate() {
        
    }
       
    
}
