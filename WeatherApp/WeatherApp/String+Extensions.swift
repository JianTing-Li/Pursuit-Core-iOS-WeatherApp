//
//  String+Extensions.swift
//  WeatherApp
//
//  Created by Jian Ting Li on 1/22/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

extension String {
    var formattedTime: String {
        let isoDateFormatter = ISO8601DateFormatter()
        var formattedDate = self
        if let date = isoDateFormatter.date(from: self) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "h:mm a"
            formattedDate = dateFormatter.string(from: date)
        }
        return formattedDate
    }
}

