//
//  MoviesRouter.swift
//  TheMovies
//
//  Created by zodiac on 30.01.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

@objc protocol MoviesRoutingLogic {
    func rotueDeatilScene()
}

protocol MoviesDataPassing {
    var dataStore: MoviesDataStore? { get }
}

class MoviesRouter: NSObject, MoviesRoutingLogic, MoviesDataPassing {
    weak var viewController: MoviesViewController?
    var dataStore: MoviesDataStore?
  
    // MARK: Routing

    func rotueDeatilScene() {
        let detailViewController = UIStoryboard.init(name: "Movies", bundle: nil).instantiateViewController(withIdentifier: "MovieViewController") as! MovieViewController
        detailViewController.modalPresentationStyle = .overFullScreen
        detailViewController.posterImageUrl = URL(string: dataStore?.movieModel?.fullPosterPath ?? "")
        detailViewController.posterTitle = dataStore?.movieModel?.name
        detailViewController.movieDescription = dataStore?.movieModel?.overview
        detailViewController.movideID = dataStore?.movieModel?.id
        detailViewController.index = dataStore?.index ?? 0
        viewController?.present(detailViewController, animated: true, completion: nil)
    }
}
