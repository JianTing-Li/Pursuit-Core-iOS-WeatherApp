//
//  AppError.swift
//  WeatherApp
//
//  Created by Jian Ting Li on 1/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

public enum AppError: Error {
    case badURL(String)
    case networkError(Error)
    case decodingError(Error)
    case badStatusCode(String)
    case badMimeType(String)
    case failToGetForecast(String, String)
    case invalidZipCode(String, Error)
    case setImageError(Error)
    case invalidePath(String)
    case propertyListDecodingError(Error)
    case propertyListdataEncodingError(Error)
    case noData
    case failToSaveImage
    
    public func errorMessage() -> String {
        switch self {
        case .badURL(let message):
            return "badUrl: \(message)"
        case .networkError(let error):
            //summary description of the error without the verbose description
            return error.localizedDescription
        case .decodingError(let error):
            return "decoding error: \(error)"
        case .badStatusCode(let message):
            return "bad status code: \(message)"
        case .badMimeType(let mimeType):            //what is the .badMimetype error?
            return "bad mime type: \(mimeType)"
        case .failToGetForecast(let errorCode, let description):
            return "\(errorCode): \(description)"
        case .invalidZipCode(let zipCode, let error):
            return "Invalid ZipCode \(zipCode): \(error)"
        case .setImageError(let error):
            return "SetImage Error: \(error)"
        case .propertyListDecodingError(let error):
            return "Property List Encoding Error: \(error)"
        case .propertyListdataEncodingError(let error):
            return "Property List Encoding Error: \(error)"
        case .invalidePath(let fileName):
            return "\(fileName) doesn't exist"
        case .noData:
            return "data is nil"
        case .failToSaveImage:
            return "Failed To Save: Image is nil"
        }
    }
}

//mime type is the media format type e.g image/jpeg or text/html
    //https://developer.mozilla.org/en-US/docs/Web/HTTP/Basics_of_HTTP/MIME_types
