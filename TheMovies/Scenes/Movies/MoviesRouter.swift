//
//  MoviesRouter.swift
//  TheMovies
//
//  Created by zodiac on 30.01.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

@objc protocol MoviesRoutingLogic {
    //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol MoviesDataPassing {
    var dataStore: MoviesDataStore? { get }
}

class MoviesRouter: NSObject, MoviesRoutingLogic, MoviesDataPassing {
    weak var viewController: MoviesViewController?
    var dataStore: MoviesDataStore?
  
    // MARK: Routing

    //func routeToSomewhere(segue: UIStoryboardSegue?) {
    //
    //  if let segue = segue {
    //    let destinationVC = segue.destination as! SomewhereViewController
    //    var destinationDS = destinationVC.router!.dataStore!
    //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //  } else {
    //    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    //    let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
    //    var destinationDS = destinationVC.router!.dataStore!
    //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //    navigateToSomewhere(source: viewController!, destination: destinationVC)
    //  }
    //}

    // MARK: Navigation

    //func navigateToSomewhere(source: MoviesViewController, destination: SomewhereViewController) {
    //
    //  source.show(destination, sender: nil)
    //}

    // MARK: Passing data

    //func passDataToSomewhere(source: MoviesDataStore, destination: inout SomewhereDataStore) {
    //
    //  destination.name = source.name
    //}
}
