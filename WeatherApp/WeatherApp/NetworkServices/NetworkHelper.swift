//
//  NetworkHelper.swift
//  WeatherApp
//
//  Created by Jian Ting Li on 1/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

final public class NetworkHelper {
    private init() {
        let cache = URLCache(memoryCapacity: 10 * 1024 * 1024, diskCapacity: 10 * 1024 * 1024, diskPath: nil)
        URLCache.shared = cache
    }
    public static let shared = NetworkHelper()
    
    public func performDataTask(endpointURLString: String, completionHandler: @escaping (AppError?, Data?, HTTPURLResponse?) -> Void) {
        guard let url = URL(string: endpointURLString) else {
            completionHandler(AppError.badURL("\(endpointURLString)"), nil, nil)
            return
        }
        let request = URLRequest(url:url)
        // **why don't we check the status code here?
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completionHandler(AppError.networkError(error), nil, response as? HTTPURLResponse)
                return
            }
            
            if let data = data {
                completionHandler(nil, data, response as? HTTPURLResponse)
            }
        }
        task.resume()
    }
}
