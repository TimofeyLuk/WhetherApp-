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
    func ImageSucces()
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
                        self.getImages()
                    case .failure(let error):
                        self.view?.failure(error: error)
                }
            }
        }
    }
    
    
    func getImages() {
        if let data = forecast?.data {
            let keysArray = Array(data.keys).map({ String($0) })
            for dayKey in keysArray {
                guard let weathersData = forecast?.data?[dayKey] else { return }
                if weathersData == nil { return }
                for el in weathersData! {
                    if forecast?.images == nil { forecast?.images = [:] }
                    guard let imageIndex = el.weather?.first?.icon else { return }
                    if forecast?.images?.keys == nil {
                        getImageReqest(imageIndex)
                    } else if !Array((forecast?.images?.keys)!).map({ String($0) }).contains(imageIndex) {
                        getImageReqest(imageIndex)
                    }
                }
            }
        }
    }
    
    func getImageReqest(_ imageIndex: String) {
        networkService?.getWeekWeatheImage(imageIndex: imageIndex, completion: { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                    case .success(let image):
                        self.forecast?.images?[imageIndex] = image
                        self.view?.ImageSucces()
                    case .failure(let error):
                        self.view?.ImageFailure(error: error)
                }
            }
        })
    }
    
    func lokationDidUpdate() {
        
    }
       
    
}
