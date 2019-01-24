//
//  Double+Extensions.swift
//  WeatherApp
//
//  Created by Jian Ting Li on 1/24/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

extension Double {
    var formattedTime: String {
        var formattedDate = self.description
        let date = Date(timeIntervalSince1970: self)    //convert timestamp to date object
        let dateFormatter = DateFormatter()             //initialized DateFormatter
        // assign the texual date format I want
        dateFormatter.dateFormat = "h:mm a"   // 6:45 AM
        // this is where the date texual conversion takes place
        formattedDate = dateFormatter.string(from: date)
        return formattedDate
    }
    
    var formattedDate: String {
        var formattedDate = self.description
        let date = Date(timeIntervalSince1970: self)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"     // 2019-01-10
        formattedDate = dateFormatter.string(from: date)
        return formattedDate
    }
}
