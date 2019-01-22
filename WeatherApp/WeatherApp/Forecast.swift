//
//  Forecast.swift
//  WeatherApp
//
//  Created by Jian Ting Li on 1/20/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

struct GetForecastStatus: Codable {
    let success: Bool
    
    struct ForecastError: Codable {
        let code: String
        let description: String
    }
    let error: ForecastError?
    let response: [ForecastData]    //only 1 element
}

struct ForecastData: Codable {
    let interval: String
    let periods: [Forecast] // <--- Goal Here!
    
    struct Location: Codable {
        let tz: String
    }
    let profile: Location
}

struct Forecast: Codable {
    let timestamp: Double      // 1547899200
    let maxTempC: Int       // 4
    let maxTempF: Int       // 39
    let minTempC: Int       // 1
    let minTempF: Int       // 33
    let precipIN: Double    // 1.27
    let windSpeedMPH: Int   // 8
    let weather: String     // "Mostly Cloudy with Chance of Light Wintry Mix",
    let weatherPrimary: String    // "Scattered Wintry Mix"
    let icon: String              // "wintrymix.png"
    let sunrise: Double
    let sunsetISO: String
    
    public var date: String {
        var formattedDate = timestamp.description
        //change the timestamp to date object
        let date = Date(timeIntervalSince1970: timestamp)
        
        //initialized the DateFormatter
        let dateFormatter = DateFormatter()
        
        // assign the texual date format I want
        dateFormatter.dateFormat = "yyyy-MM-dd"   // 2019-01-19
        
        // this is where the date texual conversion takes place
        formattedDate = dateFormatter.string(from: date)
        
        return formattedDate
    }
    
    public var iconImage: UIImage {
        let iconImageString = icon.components(separatedBy: ".")[0]
        return UIImage(named: iconImageString) ?? UIImage(named: "placeholder")!
    }
}
