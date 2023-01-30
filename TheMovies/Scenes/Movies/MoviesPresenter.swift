//
//  MoviesPresenter.swift
//  TheMovies
//
//  Created by zodiac on 30.01.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol MoviesPresentationLogic {
    func presentMovies(response: Movies.Models.Response)
    func presentFailure(message: String)
}

class MoviesPresenter: MoviesPresentationLogic {
    weak var viewController: MoviesDisplayLogic?
  
    // MARK: Present Movies
  
    func presentMovies(response: Movies.Models.Response) {
        let viewModel = Movies.Models.ViewModel(model: response.model)
        viewController?.displayMovies(viewModel: viewModel)
    }
    // MARK: Present failure
    
    func presentFailure(message: String) {
        viewController?.displayFailure(message: message)
    }
}
