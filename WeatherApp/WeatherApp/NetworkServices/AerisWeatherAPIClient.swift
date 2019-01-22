//
//  AerisWeatherAPIClient.swift
//  WeatherApp
//
//  Created by Jian Ting Li on 1/20/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

final class AerisWeatherAPIClient {
    private init() {}
    
    public static func get7DayForecastByZipCode(zipCode: String, completionHandler: @escaping (AppError?, [Forecast]?, String?) -> Void) {
        let endpointURLString = "https://api.aerisapi.com/forecasts/\(zipCode)?client_id=\(SecretKeys.aerisClientID)&client_secret=\(SecretKeys.aerisSecretKey)"
        
        NetworkHelper.shared.performDataTask(endpointURLString: endpointURLString) { (appError, data, httpResponse) in
            if let appError = appError {
                completionHandler(appError, nil, nil)
                return
            }
            guard let response = httpResponse, (200...299).contains(response.statusCode) else {
                let statusCode = httpResponse?.statusCode ?? -999
                completionHandler(AppError.badStatusCode(statusCode.description), nil, nil)
                return
            }
            if let data = data {
                do {
                    let getForecastStatus = try JSONDecoder().decode(GetForecastStatus.self, from: data)
                    guard getForecastStatus.success else {
                        if let error = getForecastStatus.error {
                            completionHandler(AppError.failToGetForecast(error.code, error.description), nil, nil)
                            return
                        }
                        completionHandler(AppError.failToGetForecast("Error:", "decode Success, but receive no data"), nil, nil)
                        return
                    }
                    let forecasts = getForecastStatus.response[0].periods
                    completionHandler(nil, forecasts, zipCode)
                } catch {
                    completionHandler(AppError.decodingError(error), nil, nil)
                }
            }
        }
    }
}
