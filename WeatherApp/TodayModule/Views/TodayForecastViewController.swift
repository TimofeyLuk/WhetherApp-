//
//  ViewController.swift
//  WeatherApp
//
//  Created by Тимофей Лукашевич on 18.09.20.
//  Copyright © 2020 Тимофей Лукашевич. All rights reserved.
//

import UIKit


class TodayForecastViewController: UIViewController {
    
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMainInfo()
        
    }
    
    func setupMainInfo() {
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
}

