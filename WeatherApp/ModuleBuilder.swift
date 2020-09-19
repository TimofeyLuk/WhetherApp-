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
}

class ModuleBuilder: Builder {
    static func createTodayForecastModule() -> UIViewController {
        let location = CurrentLokationTaker()
        let serviceForModel = TodayNetworkService(location: location)
        let view = TodayForecastViewController()
        
        _ = TodayForecastPresenter(view: view, networkService: serviceForModel)
        
        return view
    }
    
}
