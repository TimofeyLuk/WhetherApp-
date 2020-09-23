//
//  ViewController.swift
//  WeatherApp
//
//  Created by Тимофей Лукашевич on 18.09.20.
//  Copyright © 2020 Тимофей Лукашевич. All rights reserved.
//

import UIKit


class TodayForecastViewController: UIViewController, TodayForecastViewProtocol {
    
    var presenter: TodayForecastPresenterProtocol!
    
    var wetherImage: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.clipsToBounds = true
        return img
    }()
    
    var locationTitle: UILabel = {
        let location = UILabel()
        location.translatesAutoresizingMaskIntoConstraints = false
        location.textAlignment = .center
        return location
    }()
    
    var wetherTitle: UILabel = {
        let wether = UILabel()
        wether.translatesAutoresizingMaskIntoConstraints = false
        wether.font = UIFont.systemFont(ofSize: 24)
        wether.textAlignment = .center
        wether.textColor = .blue
        return wether
    }()
    
    private var cloudinessImage: UIImageView!
    var cloudinessLabel: UILabel = {
        let pressure = UILabel()
        pressure.translatesAutoresizingMaskIntoConstraints = false
        pressure.font = UIFont.systemFont(ofSize: 10)
        pressure.textAlignment = .center
        return pressure
    }()
    
    private var humidityImage: UIImageView!
    var humidityLabel: UILabel = {
        let humidity = UILabel()
        humidity.translatesAutoresizingMaskIntoConstraints = false
        humidity.font = UIFont.systemFont(ofSize: 10)
        humidity.textAlignment = .center
        return humidity
    }()
    
    private var pressureImage: UIImageView!
    var pressureLabel: UILabel = {
        let c = UILabel()
        c.translatesAutoresizingMaskIntoConstraints = false
        c.font = UIFont.systemFont(ofSize: 10)
        c.textAlignment = .center
        return c
    }()
    
    private var windSpeedImage: UIImageView!
    var windSpeedLabel: UILabel = {
        let windSpeed = UILabel()
        windSpeed.translatesAutoresizingMaskIntoConstraints = false
        windSpeed.font = UIFont.systemFont(ofSize: 10)
        windSpeed.textAlignment = .center
        return windSpeed
    }()
    
    private var SEImage: UIImageView!
    var SELabel: UILabel = {
        let se = UILabel()
        se.translatesAutoresizingMaskIntoConstraints = false
        se.font = UIFont.systemFont(ofSize: 10)
        se.textAlignment = .center
        return se
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = "Today"
        let tabBarImage = UIImage(named: "today_img")
        
        let tabBarItem = UITabBarItem(title: "Today", image: tabBarImage?.withTintColor(.gray), selectedImage: tabBarImage?.withTintColor(.blue))
        self.tabBarItem = tabBarItem
        setupUI()
    }
    
    func setupUI() {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        view.addSubview(stackView)
        
        view.addSubview(wetherImage)
        wetherImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        wetherImage.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        wetherImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
        wetherImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
        let imageName = "?"
        let image = UIImage(named: imageName)
        wetherImage.image = image
        
        //wetherImage.frame = CGRect(x: (view.frame.width / 2) - 50, y: 100, width: 100, height: 100)
        
        
        stackView.topAnchor.constraint(equalTo: wetherImage.bottomAnchor, constant: 14).isActive = true
        stackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        stackView.axis = .vertical
        locationTitle.text = "-----, --"
        stackView.addArrangedSubview(locationTitle)
        wetherTitle.text = "00ºC | -----"
        stackView.addArrangedSubview(wetherTitle)
        
        
        drawHorizontalLine(topView: stackView, goDownConstant: 30)
        setImages(goDownConstant: 320)
        
        drawHorizontalLine(topView: cloudinessImage, goDownConstant: 100)
        
        let shareButton = UIButton()
        shareButton.setTitleColor(.orange, for: .normal)
        shareButton.setTitle("Share", for: .normal)
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        shareButton.addTarget(self, action: #selector(shareAction), for: UIControl.Event.touchUpInside)
        view.addSubview(shareButton)
        shareButton.topAnchor.constraint(equalTo: cloudinessImage.bottomAnchor, constant: 140).isActive = true
        shareButton.centerXAnchor.constraint(equalTo: cloudinessImage.centerXAnchor).isActive = true
        shareButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        shareButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
    }
    
    @objc func shareAction(sender:UIButton) {
        presenter.shareForecast()
    }

    func drawHorizontalLine(topView: UIView, goDownConstant: CGFloat) {
        let lineView = UIView()
        lineView.translatesAutoresizingMaskIntoConstraints = false
        lineView.backgroundColor = .gray
        view.addSubview(lineView)
        lineView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: goDownConstant).isActive = true
        lineView.centerXAnchor.constraint(equalTo: topView.centerXAnchor).isActive = true
        lineView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        lineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    
    func setImages(goDownConstant: CGFloat) {
        let cloudiness = UIImage(named: "cloudiness")
        let humidity = UIImage(named: "humidity")
        let pressure = UIImage(named: "pressure")
        let windSpeed = UIImage(named: "windSpeed")
        let SE = UIImage(named: "SE")
        
        
        cloudinessImage = UIImageView(image: cloudiness)
        humidityImage = UIImageView(image: humidity)
        pressureImage = UIImageView(image: pressure)
        windSpeedImage = UIImageView(image: windSpeed)
        SEImage = UIImageView(image: SE)
        
        cloudinessImage.frame = CGRect(x: (view.frame.width / 2 - 10), y: goDownConstant, width: 20, height: 20)
        cloudinessLabel.text = "%"
        
        humidityImage.frame = CGRect(x: (view.frame.width / 2 - 80), y: goDownConstant, width: 20, height: 20)
        humidityLabel.text = "mm"
        
        pressureImage.frame = CGRect(x: (view.frame.width / 2 + 60), y: goDownConstant, width: 20, height: 20)
        pressureLabel.text = "hPa"
        
        windSpeedImage.frame = CGRect(x: (view.frame.width / 2 - 50), y: goDownConstant + 60, width: 20, height: 20)
        windSpeedLabel.text = "km/h"
        
        SEImage.frame = CGRect(x: (view.frame.width / 2 + 40), y: goDownConstant + 62, width: 20, height: 20)
        SELabel.text = "--"
        
        view.addSubview(cloudinessImage)
        view.addSubview(humidityImage)
        view.addSubview(pressureImage)
        view.addSubview(windSpeedImage)
        view.addSubview(SEImage)
        
        view.addSubview(cloudinessLabel)
        view.addSubview(humidityLabel)
        view.addSubview(pressureLabel)
        view.addSubview(windSpeedLabel)
        view.addSubview(SELabel)
        
        cloudinessLabel.topAnchor.constraint(equalTo: cloudinessImage.bottomAnchor, constant: 2).isActive = true
        cloudinessLabel.centerXAnchor.constraint(equalTo: cloudinessImage.centerXAnchor).isActive = true
        
        humidityLabel.topAnchor.constraint(equalTo: humidityImage.bottomAnchor, constant: 2).isActive = true
        humidityLabel.centerXAnchor.constraint(equalTo: humidityImage.centerXAnchor).isActive = true
        
        pressureLabel.topAnchor.constraint(equalTo: pressureImage.bottomAnchor, constant: 2).isActive = true
        pressureLabel.centerXAnchor.constraint(equalTo: pressureImage.centerXAnchor).isActive = true
        
        windSpeedLabel.topAnchor.constraint(equalTo: windSpeedImage.bottomAnchor, constant: 2).isActive = true
        windSpeedLabel.centerXAnchor.constraint(equalTo: windSpeedImage.centerXAnchor).isActive = true
        
        SELabel.topAnchor.constraint(equalTo: SEImage.bottomAnchor, constant: 2).isActive = true
        SELabel.centerXAnchor.constraint(equalTo: SEImage.centerXAnchor).isActive = true
    }
    
    func succes() {
        guard let forecast = presenter.forecast else {return}
        
        wetherTitle.text = "\(Int(forecast.main?.temp ?? 0))°C | " + (forecast.weather?.first?.main ?? "Error")
        locationTitle.text = (forecast.name ?? "Error") + ", " + (forecast.sys?.country ?? "ER")
        
        pressureLabel.text = "\(forecast.main?.pressure ?? 0) hPa"
        humidityLabel.text = "\(forecast.main?.humidity ?? 0) mm"
        cloudinessLabel.text = "\(forecast.clouds?.all ?? 0) %"
        windSpeedLabel.text = "\(forecast.wind?.speed ?? 0) km/h"
        SELabel.text = forecast.wind?.deg?.compasDirection ?? "--"
    }
    
    func failure(error: Error) {
        print(error.localizedDescription)
        let errorMessage = UIAlertController(title: "Connection error", message: "Please connect to the Internet. After pressing \"Ok\" button, application will try to connect again", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .cancel, handler: { (action) -> Void in
            self.presenter.getForecast()
         })
        
        errorMessage.addAction(ok)

        self.present(errorMessage, animated: true, completion: nil)
    }
    
    func ImageSucces(image: UIImage?) {
        if image != nil {
            if wetherImage.superview != self.view {
                view.addSubview(wetherImage)
                wetherImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
                wetherImage.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
                wetherImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
                wetherImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
                wetherImage.image = image
            } else {
                wetherImage.image = image!
            }
        }
    }
    
    func ImageFailure(error: Error) {
        print(error.localizedDescription)
        let errorMessage = UIAlertController(title: "Connection error", message: "the program was unable to obtain images", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        errorMessage.addAction(ok)

        self.present(errorMessage, animated: true, completion: nil)
    }
    
    
    
}


extension Int {
    var compasDirection: String {
        switch self {
        case 0...15, 345...360:
            return "N"
        case 16...74:
            return "NE"
        case 75...105:
            return "E"
        case 106...164:
            return "SE"
        case 165...195:
            return "S"
        case 196...254:
            return "SW"
        case 255...285:
            return "W"
        case 286...344:
            return "NW"
        default:
            return "--"
        }
    }
}
