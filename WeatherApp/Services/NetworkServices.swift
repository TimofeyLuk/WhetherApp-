//
//  NetworkService.swift
//  WeatherApp
//
//  Created by Тимофей Лукашевич on 18.09.20.
//  Copyright © 2020 Тимофей Лукашевич. All rights reserved.
//

import Foundation


protocol TodayNetworkServiceProtocole {
    var currentLocation: LocationServiceProtocol! { get set }
    func getCurrentWeather (completion: @escaping(Result<CurrentWeatherData?, Error>) -> Void)
    init(location: LocationServiceProtocol)
}

// MARK: - first presenter netservice (Today)

class TodayNetworkService: TodayNetworkServiceProtocole {

    required init(location: LocationServiceProtocol) {
        self.currentLocation = location
    }
    
    var currentLocation: LocationServiceProtocol!
    func getCurrentWeather(completion: @escaping (Result<CurrentWeatherData?, Error>) -> Void) {
        let urlString =
        "api.openweathermap.org/data/2.5/weather?lat=\(currentLocation.currentLat)&lon=\(currentLocation.currentLong)&units=metric&appid=a5fbd45eb862a80d161c5fb8d6c86008"
        
        guard let url =  URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, responce, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            do {
                let weather = try JSONDecoder().decode(CurrentWeatherData.self, from: data!)
                completion(.success(weather))
            } catch {
                completion(.failure(error))
            }
        }.resume()
        
    }
}

// MARK: - second presenter netservice (Week)

class WeekNetworkService {
    
    
    
}
