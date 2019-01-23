//
//  CacheImageView.swift
//  WeatherApp
//
//  Created by Jian Ting Li on 1/20/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit
// ***2 questions
//TODO: refactor set image using networkHelper

class CacheImageView: UIImageView {
    
    // setting up cache & imageViewURLString to make sure cells are displaying the right image
    private var cache = NSCache<NSString, UIImage>()
    private var imageViewURLString = ""
    
    // Setup Activity Indicator
        //create an instance here programmatically (not story board)
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .whiteLarge)
        indicator.hidesWhenStopped = true
        indicator.color = .black
        return indicator
    }()
    
    // ??? 1) what does the next 3 things do?
        // display the activity indicator
    private func commonInit() {
        addSubview(activityIndicator)
        //setting constraints
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    // ??? 2) what is the "throws" keyboard?
    public func setImage(withURLString urlString: String, placeholderImage: UIImage) throws {
        //set image to placeholder
        DispatchQueue.main.async {
            self.image = placeholderImage
        }
        //check if the image of the url is in the cache
        if let cacheImage = cache.object(forKey: urlString as NSString) {
            image = cacheImage
        } else { // if not make a network request
            imageViewURLString = urlString
            DispatchQueue.main.async {
                self.activityIndicator.startAnimating()  //start animating activity indicator
            }
            
            guard let url = URL(string: urlString) else { throw AppError.badURL("bad image url: \(urlString)") }
            let request = URLRequest(url:url)
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    print("network error: \(error)")
                }
                guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                    print("setImage - bad status code")
                    return
                }
                if let data = data {
                    //make sure the URLString on the Image is equal to the image URLString we make a network request to
                    if self.imageViewURLString == urlString {
                          // ??? 3) what is global thread? THis whole line of code
                                //image processing in the global thread
                        DispatchQueue.global(qos: .userInitiated).async {
                            if let fetchedImage = UIImage(data: data) {
                                // cache the image
                                self.cache.setObject(fetchedImage, forKey: urlString as NSString)
                                DispatchQueue.main.async {
                                    self.image = fetchedImage
                                }
                            }
                        }
                    }
                }
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                }
            }
            task.resume()
        }
    }
    
    
}
