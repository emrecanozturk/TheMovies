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
    func setMovies(index: Int, model: MovieResponseModel?)
}

protocol MoviesDataStore {
    var movieModel: MovieResponseModel? { get }
    var index     : Int? { get }
}

class MoviesInteractor: MoviesBusinessLogic, MoviesDataStore {
    var presenter: MoviesPresentationLogic?
    var worker: MoviesWorker?
    
    var movieModel: MovieResponseModel?
    var index: Int?
  
    // MARK: Present datas
  
    func getMovies(request: Movies.Models.Request) {
        presenter?.presentLoading()
        worker = MoviesWorker()
        worker?.getMovies(request: request, successCallback: { [weak self] movies in
            guard let self = self else { return }
            self.presenter?.presentMovies(response: movies)
        }, failureCallback: { [weak self] error in
            guard let self = self else { return }
            self.presenter?.presentFailure(message: error.localizedDescription)
        })
    }
    
    func setMovies(index: Int, model: MovieResponseModel?) {
        self.index = index
        self.movieModel = model
    }
}
