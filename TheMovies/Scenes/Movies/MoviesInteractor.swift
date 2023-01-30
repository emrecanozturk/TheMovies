//
//  MoviesInteractor.swift
//  TheMovies
//
//  Created by zodiac on 30.01.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol MoviesBusinessLogic {
    func getMovies(request: Movies.Models.Request)
}

protocol MoviesDataStore {
    //var name: String { get set }
}

class MoviesInteractor: MoviesBusinessLogic, MoviesDataStore {
    var presenter: MoviesPresentationLogic?
    var worker: MoviesWorker?
    //var name: String = ""
  
    // MARK: Do something
  
    func getMovies(request: Movies.Models.Request) {
        worker = MoviesWorker()
        worker?.getMovies(request: request, successCallback: { [weak self] movies in
            guard let self = self else { return }
            self.presenter?.presentMovies(response: movies)
        }, failureCallback: { [weak self] error in
            guard let self = self else { return }
            self.presenter?.presentFailure(message: error.localizedDescription)
        })
    }
}
