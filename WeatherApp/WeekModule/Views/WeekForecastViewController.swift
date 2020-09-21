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
    var forecastTable: UITableView = {
        let forecast = UITableView()
        forecast.translatesAutoresizingMaskIntoConstraints = false
        forecast.register(ForecastCell.self, forCellReuseIdentifier: "forecastCell")
        return forecast
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Forecast"
        self.view.backgroundColor = .white
        
        forecastTable.delegate = self
        forecastTable.dataSource = self
        
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
    
    

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let forecast = presenter.forecast?.data{
            let days = Array(forecast.keys).map({ String($0) })
            let key = days[section]
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let date = dateFormatter.date(from: key) ?? Date()
            
            let calendar = Calendar.current
            let weekday = calendar.component(.weekday, from: date)
        
            let daysNamesArray = ["Error", "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
            
            return daysNamesArray[weekday]
        }
        
        return " --- "
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "forecastCell", for: indexPath) as! ForecastCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        if let forecast = presenter.forecast?.data{
            let days = Array(forecast.keys).map({ String($0) })
            let key = days[indexPath.section]
            let cellData = forecast[key]??[indexPath.row]
            
            cell.weatherImage.image = presenter.forecast?.images?[cellData?.weather?.first?.icon ?? ""]
            cell.tempLapel.text =  "\(Int(cellData?.main?.temp ?? 0))°C"
            cell.weatherDescriptionsLabel.text = cellData?.weather?.first?.main
            cell.timeLable.text = cellData?.time
            
        }
        return cell
    }
        

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.backgroundColor = .white
        cell?.layer.borderWidth = 2
        cell?.layer.borderColor = UIColor.blue.cgColor
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.backgroundColor = .white
        cell?.layer.borderWidth = 0
        cell?.layer.borderColor = UIColor.white.cgColor
    }
    
    func succes() {
        forecastTable.reloadData()
        self.navigationItem.title = presenter.forecast?.city?.name ?? "Forecast"
    }
    
    func failure(error: Error) {
        print(error.localizedDescription)
        let errorMessage = UIAlertController(title: "Connection error", message: "Please connect to the Internet and restart the application", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            exit(1)
         })
        
        errorMessage.addAction(ok)

        self.present(errorMessage, animated: true, completion: nil)
    }
    
    func ImageSucces() {
        forecastTable.reloadData()
    }
    
    func ImageFailure(error: Error) {
         print(error.localizedDescription)
         let errorMessage = UIAlertController(title: "Connection error", message: "the program was unable to obtain images", preferredStyle: .alert)
         let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
         
         errorMessage.addAction(ok)

         self.present(errorMessage, animated: true, completion: nil)
    }
    
    
    
}
