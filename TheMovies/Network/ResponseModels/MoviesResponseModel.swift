//
//  MoviesResponseModel.swift
//  TheMovies
//
//  Created by zodiac on 30.01.2023.
//

import Foundation

struct MoviesResponseModel: BaseResponseProtocol {
    let totalPages  : Int?
    let totalResults: Int?
    var results     : [MovieResponseModel]?
}

struct MovieResponseModel: BaseResponseProtocol {
    let name              : String?
    let overview          : String?
    let voteAverage       : Float?
    let firstAirDate      : String?
    private let posterPath: String?
    var fullPosterPath    : String {
        return "https://image.tmdb.org/t/p/original" + (posterPath ?? "")
    }
}
