//
//  ViewController.swift
//  WeatherApp
//
//  Created by Тимофей Лукашевич on 18.09.20.
//  Copyright © 2020 Тимофей Лукашевич. All rights reserved.
//

import UIKit


class TodayForecastViewController: UIViewController, TodayForecastViewProtocol {
    
    var wetherImage: UIImageView!
    
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
    
    private var pressureImage: UIImageView!
    var pressureLabel: UILabel = {
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
    
    private var cImage: UIImageView!
    var cLabel: UILabel = {
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
        self.title = "Today"
        setupUI()
    }
    
    func setupUI() {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        view.addSubview(stackView)
        
        let imageName = "?"
        let image = UIImage(named: imageName)
        wetherImage = UIImageView(image: image!)
        
        wetherImage.frame = CGRect(x: (view.frame.width / 2) - 50, y: 40, width: 100, height: 100)
        view.addSubview(wetherImage)
        stackView.topAnchor.constraint(equalTo: wetherImage.bottomAnchor, constant: 14).isActive = true
        stackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        stackView.axis = .vertical
        locationTitle.text = "Error,ER"
        stackView.addArrangedSubview(locationTitle)
        wetherTitle.text = "00ºC | Error"
        stackView.addArrangedSubview(wetherTitle)
        
        
        drawHorizontalLine(topView: stackView, goDownConstant: 30)
        setImages(goDownConstant: 300)
        
        drawHorizontalLine(topView: pressureImage, goDownConstant: 100)
        
        let shareButton = UIButton()
        shareButton.setTitleColor(.orange, for: .normal)
        shareButton.setTitle("Share", for: .normal)
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(shareButton)
        shareButton.topAnchor.constraint(equalTo: pressureImage.bottomAnchor, constant: 140).isActive = true
        shareButton.centerXAnchor.constraint(equalTo: pressureImage.centerXAnchor).isActive = true
        shareButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        shareButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
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
        let pressure = UIImage(named: "pressure")
        let humidity = UIImage(named: "humidity")
        let c = UIImage(named: "C")
        let windSpeed = UIImage(named: "windSpeed")
        let SE = UIImage(named: "SE")
        
        
        pressureImage = UIImageView(image: pressure)
        humidityImage = UIImageView(image: humidity)
        cImage = UIImageView(image: c)
        windSpeedImage = UIImageView(image: windSpeed)
        SEImage = UIImageView(image: SE)
        
        pressureImage.frame = CGRect(x: (view.frame.width / 2 - 10), y: goDownConstant, width: 20, height: 20)
        pressureLabel.text = "%"
        
        humidityImage.frame = CGRect(x: (view.frame.width / 2 - 80), y: goDownConstant, width: 20, height: 20)
        humidityLabel.text = "mm"
        
        cImage.frame = CGRect(x: (view.frame.width / 2 + 60), y: goDownConstant, width: 20, height: 20)
        cLabel.text = "hPa"
        
        windSpeedImage.frame = CGRect(x: (view.frame.width / 2 - 50), y: goDownConstant + 60, width: 20, height: 20)
        windSpeedLabel.text = "km/h"
        
        SEImage.frame = CGRect(x: (view.frame.width / 2 + 40), y: goDownConstant + 62, width: 20, height: 20)
        SELabel.text = "--"
        
        view.addSubview(pressureImage)
        view.addSubview(humidityImage)
        view.addSubview(cImage)
        view.addSubview(windSpeedImage)
        view.addSubview(SEImage)
        
        view.addSubview(pressureLabel)
        view.addSubview(humidityLabel)
        view.addSubview(cLabel)
        view.addSubview(windSpeedLabel)
        view.addSubview(SELabel)
        
        pressureLabel.topAnchor.constraint(equalTo: pressureImage.bottomAnchor, constant: 2).isActive = true
        pressureLabel.centerXAnchor.constraint(equalTo: pressureImage.centerXAnchor).isActive = true
        
        humidityLabel.topAnchor.constraint(equalTo: humidityImage.bottomAnchor, constant: 2).isActive = true
        humidityLabel.centerXAnchor.constraint(equalTo: humidityImage.centerXAnchor).isActive = true
        
        cLabel.topAnchor.constraint(equalTo: cImage.bottomAnchor, constant: 2).isActive = true
        cLabel.centerXAnchor.constraint(equalTo: cImage.centerXAnchor).isActive = true
        
        windSpeedLabel.topAnchor.constraint(equalTo: windSpeedImage.bottomAnchor, constant: 2).isActive = true
        windSpeedLabel.centerXAnchor.constraint(equalTo: windSpeedImage.centerXAnchor).isActive = true
        
        SELabel.topAnchor.constraint(equalTo: SEImage.bottomAnchor, constant: 2).isActive = true
        SELabel.centerXAnchor.constraint(equalTo: SEImage.centerXAnchor).isActive = true
    }
    
    func succes() {
        
    }
    
    func failure(error: Error) {
        
    }
}

