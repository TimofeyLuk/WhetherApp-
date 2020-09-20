//
//  WeekForecastViewController.swift
//  WeatherApp
//
//  Created by Тимофей Лукашевич on 20.09.20.
//  Copyright © 2020 Тимофей Лукашевич. All rights reserved.
//

import UIKit

class WeekForecastViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, WeekForecastViewProtocol{
    
    var presenter: WeekForecastPresenterProtocol!
    var forecastTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Forecast"
        self.view.backgroundColor = .white
        
        forecastTable = UITableView()
        forecastTable.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(forecastTable)
        forecastTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        forecastTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        forecastTable.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.forecast?.data?.keys.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let forecast = presenter.forecast?.data{
            let days = Array(forecast.keys).map({ String($0) })
            let key = days[section]
            
            return forecast[key]??.count ?? 0
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "forecastCell", for: indexPath)
        return cell
    }
    
    
    
    func succes() {
        
    }
    
    func failure(error: Error) {
        
    }
    
    func ImageSucces(image: UIImage?) {
        
    }
    
    func ImageFailure(error: Error) {
        
    }
    
    
    
}
