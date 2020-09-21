//
//  ForecastCell.swift
//  WeatherApp
//
//  Created by Тимофей Лукашевич on 20.09.20.
//  Copyright © 2020 Тимофей Лукашевич. All rights reserved.
//

import UIKit

class ForecastCell: UITableViewCell {

    var weatherImage: UIImageView!
    var timeLable: UILabel = {
        let time = UILabel()
        time.translatesAutoresizingMaskIntoConstraints = false
        time.font = UIFont.systemFont(ofSize: 20)
        time.textAlignment = .left
        return time
    }()
    var weatherDescriptionsLabel: UILabel = {
        let wether = UILabel()
        wether.translatesAutoresizingMaskIntoConstraints = false
        wether.font = UIFont.systemFont(ofSize: 16)
        wether.textAlignment = .left
        return wether
    }()
    var tempLapel: UILabel = {
        let temp = UILabel()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.font = UIFont.systemFont(ofSize: 45)
        temp.textAlignment = .left
        temp.textColor = .blue
        return temp
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        weatherImage = UIImageView()
        
        timeLable.frame = CGRect(x: 90, y: 35, width: 100, height: 15)
        //timeLable.text = "time"
        
        weatherDescriptionsLabel.frame = CGRect(x: 90, y: 60, width: 200, height: 12)
        //weatherDescriptionsLabel.text = "weather descriptions"
        
        tempLapel.frame = CGRect(x: 270, y: 4, width: 120, height: 100)
        //tempLapel.text = "00°C"
        
        weatherImage.frame = CGRect(x: 15, y: 15, width: 70, height: 70)
        
        self.addSubview(weatherImage)
        self.addSubview(timeLable)
        self.addSubview(weatherDescriptionsLabel)
        self.addSubview(tempLapel)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        if highlighted {
            self.backgroundColor = .white
            self.layer.borderWidth = 2
            self.layer.borderColor = UIColor.blue.cgColor
        } else {
            self.backgroundColor = .white
            self.layer.borderWidth = 0
            self.layer.borderColor = UIColor.white.cgColor
        }
    }
    

}
