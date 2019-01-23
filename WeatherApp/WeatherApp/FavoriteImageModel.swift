//
//  FavoriteImageModel.swift
//  WeatherApp
//
//  Created by Jian Ting Li on 1/21/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

public struct FavoriteImage: Codable {
    let imageData: Data
}

final class FavoriteImageModel {
    private static let filename = "FavoriteList.plist"
    private static var favoriteImages = [FavoriteImage]()
    
    public static func getAllFavoriteImages() -> [FavoriteImage] {
        let path = DataPersistenceManager.filepathToDocumentsDirectory(filename: filename).path
        if FileManager.default.fileExists(atPath: path) {
            if let data = FileManager.default.contents(atPath: path) {
                do {
                    favoriteImages = try PropertyListDecoder().decode([FavoriteImage].self, from: data)
                } catch {
                    print(AppError.propertyListDecodingError(error).errorMessage())
                }
            } else {
                print(AppError.noData.errorMessage())
            }
        } else {
            print(AppError.invalidePath(filename).errorMessage())
        }
        return favoriteImages
    }
    
    public static func saveFavoriteImagesToLocalMemory() {
        let path = DataPersistenceManager.filepathToDocumentsDirectory(filename: filename)
        do {
            let data = try PropertyListEncoder().encode(favoriteImages)
            try data.write(to: path, options: .atomic)
        } catch {
            print(AppError.propertyListdataEncodingError(error).errorMessage())
        }
    }
    
    public static func addFavoriteImage(image: FavoriteImage) {
        favoriteImages.append(image)
        saveFavoriteImagesToLocalMemory()
    }
    
    public static func deleteFavoriteImage(image: FavoriteImage, at index: Int) {
        favoriteImages.remove(at: index)
        saveFavoriteImagesToLocalMemory()
    }
}
