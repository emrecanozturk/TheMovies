//
//  MovieInteractor.swift
//  Flicks
//
//  Created by Emrecan Ozturk on 4.01.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.


import UIKit

protocol MovieBusinessLogic {
    func getMovie(request: Movie.Models.Request)
}

protocol MovieDataStore {
    var movieModel: Movie.Models.ViewModel! { get set }
}

class MovieInteractor: MovieBusinessLogic, MovieDataStore {
    
    var presenter : MoviePresentationLogic?
    var worker    : MovieWorker?
    
    var movieModel: Movie.Models.ViewModel!
  
    // MARK: Get Movie
  
    func getMovie(request: Movie.Models.Request) {
    }
}
