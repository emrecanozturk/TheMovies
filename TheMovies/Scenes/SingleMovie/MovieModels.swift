//
//  MovieModels.swift
//  Flicks
//
//  Created by Emrecan Ozturk on 4.01.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.


import UIKit

enum Movie {
    // MARK: Use cases
  
    enum Models {
        struct Request {
            let id: Int
        }
        struct Response {}
        struct ViewModel {
            var name         : String
            var overview     : String
            var voteAverage  : Float
            var firstAirDate : String
            var posterPath   : String
            var index        : Int
        }
    }
}
