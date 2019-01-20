//
//  Image.swift
//  WeatherApp
//
//  Created by Jian Ting Li on 1/20/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct Image: Codable {
    struct ImageData: Codable {
        let hits: [Image]
    }
    let largeImageURL: URL
    let webformatHeight: Int
    let webformatWidth: Int
    let imageWidth: Int
    let imageHeight: Int
    let webformatURL: URL
    let type: String          // "photo"
    let previewHeight: Int
    let tags: String          // "new york city, brooklyn bridge, night",
    let previewWidth: Int
    let previewURL: URL
}
