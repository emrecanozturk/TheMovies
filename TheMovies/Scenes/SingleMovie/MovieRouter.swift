//
//  MovieRouter.swift
//  Flicks
//
//  Created by Emrecan Ozturk on 4.01.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.


import UIKit

@objc protocol MovieRoutingLogic {
    //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol MovieDataPassing {
    var dataStore: MovieDataStore! { get set }
}

class MovieRouter: NSObject, MovieRoutingLogic, MovieDataPassing {
    weak var viewController: MovieViewController?
    var dataStore: MovieDataStore!
  
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

    //func navigateToSomewhere(source: MovieViewController, destination: SomewhereViewController) {
    //
    //  source.show(destination, sender: nil)
    //}

    // MARK: Passing data

    //func passDataToSomewhere(source: MovieDataStore, destination: inout SomewhereDataStore) {
    //
    //  destination.name = source.name
    //}
}
