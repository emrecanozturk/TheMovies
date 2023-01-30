//
//  MoviePresenter.swift
//  Flicks
//
//  Created by Emrecan Ozturk on 4.01.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.


import UIKit

protocol MoviePresentationLogic {
    func presentMovie(response: Movie.Models.Response)
    func presentFailure(message: String)
}

class MoviePresenter: MoviePresentationLogic {
    weak var viewController: MovieDisplayLogic?
  
    // MARK: Present Movie
  
    func presentMovie(response: Movie.Models.Response) {
//        viewController?.displayMovie(viewModel: viewModel)
    }
    func presentFailure(message: String) {
//        viewController?.displayFailure(message: message)
    }
}
