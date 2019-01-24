//
//  UserDefaultsHelper.swift
//  WeatherApp
//
//  Created by Jian Ting Li on 1/23/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

// ***1question: what are these used for?
final class UserDefaultsHelper {
    public static func retrieveDoubleFromKey(key: String) -> Double {
        return UserDefaults.standard.double(forKey: key)
    }

    public static func retrieveStringFromKey(key: String) -> String? {
        return UserDefaults.standard.string(forKey: key)
    }
}
