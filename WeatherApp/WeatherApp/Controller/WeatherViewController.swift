//
//  ViewController.swift
//  WeatherApp
//
//  Created by Alex Paul on 1/17/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {

    @IBOutlet weak var weatherCollectionView: UICollectionView!
    @IBOutlet weak var locationLabel: UILabel!
    
    var zipCode = 11229 {
        didSet {
            ZipCodeHelper.getLocationName(from: zipCode.description) { (error, locationName) in
                if let error = error {
                    print(error)
                } else if let locationName = locationName {
                    self.locationLabel.text = "Weather Forecast for \(locationName)"
                }
            }
        }
    }
    var forecasts = [Forecast]() {
        didSet {
            DispatchQueue.main.async {
                self.weatherCollectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherCollectionView.dataSource = self
        weatherCollectionView.delegate = self
        
        AerisWeatherAPIClient.get7DayForecastByZipCode(zipCode: 11229) { (appError, forecasts, zipCode) in
            if let appError = appError {
                print(appError.errorMessage())
            } else if let forecasts = forecasts, let zipCode = zipCode {
                self.zipCode = zipCode
                self.forecasts = forecasts
                //dump(self.forecasts)
            }
        }
    }


}

extension WeatherViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return forecasts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = weatherCollectionView.dequeueReusableCell(withReuseIdentifier: "ForecastCell", for: indexPath) as? ForecastCell else { fatalError("ForecastCell or identifier not found") }
        let forecast = forecasts[indexPath.row]
        cell.configureCell(forecast: forecast)
        return cell
    }
}

extension WeatherViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 250, height: 350)
    }
}
