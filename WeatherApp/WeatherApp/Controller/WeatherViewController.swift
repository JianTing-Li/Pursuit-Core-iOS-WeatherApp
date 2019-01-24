//
//  ViewController.swift
//  WeatherApp
//
//  Created by Alex Paul on 1/17/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit
// TO_DO:
    // 1*) User Defaults that save city / zipcode inputs
    // 2a) search by location name too (bonus)
    // 2b*) guard against bad inputs for zipcode & city (make sure the zipcode is good before making the api call)
    // 2c*) alert user if zipcode / city is invalid


class WeatherViewController: UIViewController {

    @IBOutlet weak var weatherCollectionView: UICollectionView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var zipCodeTextField: UITextField!
    
    var locationName = ""
    var zipCode = "11229" {
        didSet {
            AerisWeatherAPIClient.get7DayForecastByZipCode(zipCode: self.zipCode) { (appError, forecasts) in
                if let appError = appError {
                    print(appError.errorMessage())
                } else if let forecasts = forecasts {
                    self.forecasts = forecasts
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
        zipCodeTextField.delegate = self
        title = "Search"
        if let savedZipCode = UserDefaults.standard.object(forKey: UserDefaultKeys.zipCode) as? String {
            getForecastsAndUpdateUI(zipCode: savedZipCode)
        } else {
            getForecastsAndUpdateUI(zipCode: 11229.description)
        }
    }

    private func getForecastsAndUpdateUI(zipCode: String) {
        ZipCodeHelper.getLocationName(from: zipCode) { (error, locationName) in
            if let error = error {
                print(AppError.invalidZipCode(zipCode, error).errorMessage())
                //set alert here
            } else if let locationName = locationName {
                DispatchQueue.main.async {
                    self.locationName = locationName
                    self.locationLabel.text = "Weather Forecast for \(locationName)"
                    self.zipCode = zipCode
                    UserDefaults.standard.set(zipCode, forKey: UserDefaultKeys.zipCode)
                }
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
        return CGSize(width: 250/1.5, height: 350/1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let mainStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        guard let detailVC = mainStoryboard.instantiateViewController(withIdentifier: "WeatherDetailVC") as? WeatherDetailViewController else { fatalError("WeatherDetailVC is nil") }
        detailVC.forecast = forecasts[indexPath.row]
        detailVC.locationName = locationName
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension WeatherViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        guard let text = textField.text else { return false }
        getForecastsAndUpdateUI(zipCode: text)
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
}
