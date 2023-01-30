//
//  MoviesWorker.swift
//  TheMovies
//
//  Created by zodiac on 30.01.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

typealias callbackMoviesSuccess = (_ response: Movies.Models.Response) ->()
typealias callbackFailure       = (_ response: Error) ->()

import UIKit

class MoviesWorker {

    func getMovies(request: Movies.Models.Request, successCallback: @escaping callbackMoviesSuccess, failureCallback: @escaping callbackFailure) {
        let req = NetworkRequest(path: "/tv/popular", queryItems: [URLQueryItem(name: "page", value: request.page.description)])
        Network.shared.send(req) { (result: Result<MoviesResponseModel, Error>) in
            switch result {
            case .success(let model):
                successCallback(Movies.Models.Response.init(model: model))
            case .failure(let error):
                failureCallback(error)
            }
        }
    }
    
}
