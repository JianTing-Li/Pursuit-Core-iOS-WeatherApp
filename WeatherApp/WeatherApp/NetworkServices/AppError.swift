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
    case noResponse
    case decodingError(Error)
    case encodingError(Error)
    case badStatusCode(String)
    case badMimetype(String)
    
    public func errorMessage() -> String {
        switch self {
        case .badURL(let message):
            return "badUrl: \(message)"
        case .networkError(let error):
            return error.localizedDescription   // ??? what is this???
        case .noResponse:                       // different btw noResponse and networkError
            return "no network response"
        case .decodingError(let error):
            return "decoding error: \(error)"
        case .encodingError(let error):
            return "property list encoding error: \(error)"
        case .badStatusCode(let message):
            return "bad status code: \(message)"
        case .badMimetype(let mimeType):            //what is the .badMimetype error?
            return "bad mime type: \(mimeType)"
        }
    }
}
