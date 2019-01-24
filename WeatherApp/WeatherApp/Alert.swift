//
//  Alert.swift
//  WeatherApp
//
//  Created by Jian Ting Li on 1/24/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

struct Alert {
    private func showBasicAlert(on vc: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        vc.present(alert, animated: true)
    }
    
    public func showInvalidZipCode(on vc: UIViewController) {
        showBasicAlert(on: vc, title: "Invalid Zipcode", message: "Please try again 🙂")
    }
}
