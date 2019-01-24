//
//  Alert.swift
//  WeatherApp
//
//  Created by Jian Ting Li on 1/24/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

struct Alert {
    private static func showBasicAlert(on vc: UIViewController, title: String, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        vc.present(alert, animated: true)
    }
    
    public static func showInvalidZipCode(on vc: UIViewController) {
        showBasicAlert(on: vc, title: "Invalid Zipcode", message: "Please try again 🙂")
    } 
    
    public static func showImageSaved(on vc: UIViewController) {
        showBasicAlert(on: vc, title: "Image Saved", message: nil)
    }
    
    public static func showImageAlreadySaved(on vc: UIViewController) {
        showBasicAlert(on: vc, title: "Image Already Saved", message: nil)
    }
}
