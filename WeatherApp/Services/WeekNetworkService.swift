//
//  WeekNetworkService.swift
//  WeatherApp
//
//  Created by Тимофей Лукашевич on 20.09.20.
//  Copyright © 2020 Тимофей Лукашевич. All rights reserved.
//

import UIKit

protocol WeekNetworkServiceProtocol: class {
    var currentLocation: LocationServiceProtocol! { get set }
    func getWeekWeather (completion: @escaping(Result<WeekForecast?, Error>) -> Void)
    func getWeekWeatheImage ( imageIndex: String, completion: @escaping (Result<UIImage?, Error>) -> Void)
    init(location: LocationServiceProtocol)
}


class WeekNetworkService: WeekNetworkServiceProtocol {
    var currentLocation: LocationServiceProtocol!
    
    required init(location: LocationServiceProtocol) {
        self.currentLocation = location
    }
    
    func getWeekWeather(completion: @escaping (Result<WeekForecast?, Error>) -> Void) {
        let urlString = "https://api.openweathermap.org/data/2.5/forecast?lat=\(currentLocation.currentLat)&lon=\(currentLocation.currentLong)&units=metric&appid=a5fbd45eb862a80d161c5fb8d6c86008"
        
        guard let url =  URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, responce, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            do {
                let weather = try JSONDecoder().decode(WeekForecast.self, from: data!)
                completion(.success(weather))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func getWeekWeatheImage(imageIndex: String, completion: @escaping (Result<UIImage?, Error>) -> Void) {
        let urlString = "https://openweathermap.org/img/wn/\(imageIndex)@2x.png"
        guard let url =  URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, responce, error) in
            if let error = error, data == nil {
                completion(.failure(error))
                return
            }
            
            let image = UIImage(data: data!)
            completion(.success(image))
            
        }.resume()
    }
           
}
