//
//  ForecastCell.swift
//  WeatherApp
//
//  Created by Тимофей Лукашевич on 20.09.20.
//  Copyright © 2020 Тимофей Лукашевич. All rights reserved.
//

import UIKit

class ForecastCell: UITableViewCell {

    var weatherImage: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.clipsToBounds = true
        return img
    }()
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
        self.addSubview(weatherImage)
        self.addSubview(timeLable)
        self.addSubview(weatherDescriptionsLabel)
        self.addSubview(tempLapel)
        
        weatherImage.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 7).isActive = true
        weatherImage.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 7).isActive = true
        weatherImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
        weatherImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        timeLable.leftAnchor.constraint(equalTo: weatherImage.rightAnchor, constant: 20).isActive = true
        timeLable.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 25).isActive = true
        
        weatherDescriptionsLabel.leftAnchor.constraint(equalTo: weatherImage.rightAnchor, constant: 20).isActive = true
        weatherDescriptionsLabel.topAnchor.constraint(equalTo: timeLable.bottomAnchor, constant: 5).isActive = true
        
        tempLapel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 25).isActive = true
        tempLapel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: self.contentView.frame.width - 50).isActive = true
        //tempLapel.leftAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -100).isActive = true

    }
        
    required init?(coder: NSCoder) {
        super.init(coder: coder)
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
