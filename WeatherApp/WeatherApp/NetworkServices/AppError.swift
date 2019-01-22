//
//  AppError.swift
//  WeatherApp
//
//  Created by Jian Ting Li on 1/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation
//3 questions
public enum AppError: Error {
    case badURL(String)
    case networkError(Error)
    case decodingError(Error)
    case encodingError(Error)
    case badStatusCode(String)
    case badMimeType(String)
    case failToGetForecast(String, String)
    case invalidZipCode(String, Error)
    
    public func errorMessage() -> String {
        switch self {
        case .badURL(let message):
            return "badUrl: \(message)"
        case .networkError(let error):
            //summary description of the error without the verbose description
            return error.localizedDescription
        case .decodingError(let error):
            return "decoding error: \(error)"
        case .encodingError(let error):
            return "property list encoding error: \(error)"
        case .badStatusCode(let message):
            return "bad status code: \(message)"
        case .badMimeType(let mimeType):            //what is the .badMimetype error?
            return "bad mime type: \(mimeType)"
        case .failToGetForecast(let errorCode, let description):
            return "\(errorCode): \(description)"
        case .invalidZipCode(let zipCode, let error):
            return "Invalid ZipCode \(zipCode): \(error)"
        }
    }
}

//mime type is the media format type e.g image/jpeg or text/html
    //https://developer.mozilla.org/en-US/docs/Web/HTTP/Basics_of_HTTP/MIME_types
