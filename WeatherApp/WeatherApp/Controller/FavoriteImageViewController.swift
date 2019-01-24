//
//  FavoriteImageViewController.swift
//  WeatherApp
//
//  Created by Jian Ting Li on 1/20/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

// TODO: when an image is click
// Bug: Favorite photos resets is gone when I search for another city and save image there

class FavoriteImageViewController: UIViewController {

    @IBOutlet weak var favoriteImagesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteImagesTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        favoriteImagesTableView.reloadData()
        favoriteImagesTableView.delegate = self
    }

}

extension FavoriteImageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FavoriteImageModel.getAllFavoriteImages().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = favoriteImagesTableView.dequeueReusableCell(withIdentifier: "FavoriteImageCell", for: indexPath) as? FavoriteImageCell else { fatalError("FavoriteImageCell is nil") }
        let favoriteImage = FavoriteImageModel.getAllFavoriteImages()[indexPath.row]
        cell.favoriteImage.image = UIImage.init(data: favoriteImage.imageData)
        return cell
    }
}

extension FavoriteImageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
}
