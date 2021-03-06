//
//  WeatherDetailViewController.swift
//  WeatherApp
//
//  Created by Jian Ting Li on 1/20/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

// TODO:
    // 1) don't save images that's already been save (modify stuct of image model and compare URL)
    // 2) before we get image the imageURLString is set
class WeatherDetailViewController: UIViewController {
    
    @IBOutlet weak var weatherTitleLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var highTempLabel: UILabel!
    @IBOutlet weak var lowTempLabel: UILabel!
    @IBOutlet weak var sunriseTimeLabel: UILabel!
    @IBOutlet weak var sunsetTmeLabel: UILabel!
    @IBOutlet weak var windspeedLabel: UILabel!
    @IBOutlet weak var precipitationLabel: UILabel!
    @IBOutlet weak var locationImage: CacheImageView!
    
    var forecast: Forecast!
    var locationName = "Unknown"
    //var imageURLString = ""

    var locationImages = [PixabayImage]()
    var getImagesAPICallTask = false {
        didSet {
            if getImagesAPICallTask == true {
                setLocationImageUI(locationImages: locationImages)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        getPictures()
        setRightBarButtonToFavoriteImage()
    }
    
    private func updateUI() {
        title = "Forecast"
        weatherTitleLabel.text = "Weather Forecast for \(locationName) on \(forecast.timestamp.formattedDate)"
        weatherDescriptionLabel.text = forecast.weatherPrimary
        highTempLabel.text = "High: \(forecast.maxTempF)°F"
        lowTempLabel.text = "Low: \(forecast.minTempF)°F"
        sunriseTimeLabel.text = "Sunrise: \(forecast.sunrise.formattedTime)"
        sunsetTmeLabel.text = "Sunset: \(forecast.sunsetISO.formattedTime)"
        windspeedLabel.text = "Windspeed: \(forecast.windSpeedMPH) MPH"
        precipitationLabel.text = "Inches of Precipitation: \(forecast.precipIN)"
    }
    
    private func getPictures() {
        PixabayAPIClient.getImagesByLocationName(locationName: locationName) { (appError, images) in
            if let appError = appError {
                print(appError.errorMessage())
            } else if let images = images {
                self.locationImages = images
                self.getImagesAPICallTask = true
            }
        }
    }
    
    private func setLocationImageUI(locationImages: [PixabayImage]) {
        let randomImage = locationImages.randomElement()
        let randomImageURLStr = randomImage!.largeImageURL.absoluteString

        do {
            try locationImage.setImage(withURLString: randomImageURLStr,
                                       placeholderImage: UIImage(named: "placeholder")!)
        } catch {
            print(AppError.setImageError(error).errorMessage())
        }
    }
    
    // http://swiftdeveloperblog.com/code-examples/create-uibarbuttonitem-programmatically/
    private func setRightBarButtonToFavoriteImage() {
        let rightBarButton = UIBarButtonItem(title: "Save", style: UIBarButtonItem.Style.plain, target: self, action: #selector(WeatherDetailViewController.myRightSideBarButtonItemTapped(_:)))
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    @objc private func myRightSideBarButtonItemTapped(_ sender:UIBarButtonItem!) {
        print("myRightSideBarButtonItemTapped")
        guard let imageData = locationImage.image?.jpegData(compressionQuality: 0.5) else {
            print(AppError.failToSaveImage.errorMessage())
            return
        }
        let favoriteImage = FavoriteImage.init(imageData: imageData)
        FavoriteImageModel.addFavoriteImage(image: favoriteImage)
        Alert.showImageSaved(on: self)
        print("Image Favorited Cool!!")
    }
}
