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
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
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
