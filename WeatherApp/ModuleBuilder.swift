//
//  ModuleBuilder.swift
//  WeatherApp
//
//  Created by Тимофей Лукашевич on 19.09.20.
//  Copyright © 2020 Тимофей Лукашевич. All rights reserved.
//

import UIKit

protocol Builder {
    static func createTodayForecastModule() -> UIViewController
    static func createWeekForecastModule() -> UIViewController
}

class ModuleBuilder: Builder {
    
    static let location = CurrentLokationTaker()
    
    static func createTodayForecastModule() -> UIViewController {
        let serviceForModel = TodayNetworkService(location: ModuleBuilder.location)
        let view = TodayForecastViewController()
        
        _ = TodayForecastPresenter(view: view, networkService: serviceForModel)
        
        return view
    }
    
    static func createWeekForecastModule() -> UIViewController {
        let networkService = WeekNetworkService(location: ModuleBuilder.location)
        let view = WeekForecastViewController()
        
        _ = WeekForecastPresenter(view: view, networkService: networkService)
        
        return view
    }
    
}
