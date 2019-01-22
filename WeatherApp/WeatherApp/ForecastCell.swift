//
//  ForecastCell.swift
//  WeatherApp
//
//  Created by Jian Ting Li on 1/20/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ForecastCell: UICollectionViewCell {
    @IBOutlet weak var forecastDate: UILabel!
    @IBOutlet weak var forecastImage: UIImageView!
    @IBOutlet weak var highTemp: UILabel!
    @IBOutlet weak var lowTemp: UILabel!
    
    public func configureCell(forecast: Forecast) {
        forecastDate.text = forecast.date
        forecastImage.image = forecast.iconImage
        highTemp.text = "High: \(forecast.maxTempF.description)°F"
        lowTemp.text = "Low: \(forecast.minTempF.description)°F"
    }
}
