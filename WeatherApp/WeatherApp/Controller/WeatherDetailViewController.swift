//
//  WeatherDetailViewController.swift
//  WeatherApp
//
//  Created by Jian Ting Li on 1/20/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

// TODO: need to convert date
class WeatherDetailViewController: UIViewController {
    
    @IBOutlet weak var weatherTitleLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var highTempLabel: UILabel!
    @IBOutlet weak var lowTempLabel: UILabel!
    @IBOutlet weak var sunriseTimeLabel: UILabel!
    @IBOutlet weak var sunsetTmeLabel: UILabel!
    @IBOutlet weak var windspeedLabel: UILabel!
    @IBOutlet weak var precipitationLabel: UILabel!
    @IBOutlet weak var locationImage: CacheImageView!
    
    var forecast: Forecast!
    var locationName = "Unknown"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    private func updateUI() {
        weatherTitleLabel.text = "Weather Forecast for \(locationName) on \(forecast.date)"
        weatherDescriptionLabel.text = forecast.weatherPrimary
        highTempLabel.text = "High: \(forecast.maxTempF)°F"
        lowTempLabel.text = "Low: \(forecast.minTempF)°F"
        sunriseTimeLabel.text = "Sunrise: \(forecast.sunrise)"
        sunsetTmeLabel.text = "Sunset: \(forecast.sunsetISO)"
        windspeedLabel.text = "Windspeed: \(forecast.windSpeedMPH) MPH"
        precipitationLabel.text = "Inches of Precipitation: \(forecast.precipIN)"
    }
}
