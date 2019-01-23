//
//  PixabayAPIClient.swift
//  WeatherApp
//
//  Created by Jian Ting Li on 1/20/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

final class PixabayAPIClient {
    private init() {}
    
    public static func getImagesByLocationName(locationName: String, completionHandler: @escaping (AppError?, [PixabayImage]?) -> Void) {
        let formattedLocationName = locationName.contains(" ") ? locationName.replacingOccurrences(of: " ", with: "+") : locationName
        let endpointURLString = "https://pixabay.com/api/?key=\(SecretKeys.pixabaySecretKey)&q=\(formattedLocationName)&image_type=photo"
        
        NetworkHelper.shared.performDataTask(endpointURLString: endpointURLString) { (appError, data, httpResponse) in
            if let appError = appError {
                completionHandler(appError, nil)
                return
            }

//            guard let response = httpResponse, (200...299).contains(response.statusCode) else {
//                let statusCode = httpResponse?.statusCode ?? -999
//                completionHandler(AppError.badStatusCode(statusCode.description), nil)
//                return
//            }
            
            if let data = data {
                do {
                    let pixabayData = try JSONDecoder().decode(PixabayImage.PixabayImageData.self, from: data)
                    completionHandler(nil, pixabayData.hits)
                } catch {
                    completionHandler(AppError.decodingError(error), nil)
                }
            }
        }
    }
}
