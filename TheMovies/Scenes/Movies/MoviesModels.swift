//
//  MoviesModels.swift
//  TheMovies
//
//  Created by zodiac on 30.01.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum Movies {
    // MARK: Use cases
  
    enum Models {
        struct Request {
            let page: Int
        }
        struct Response {
            var model: MoviesResponseModel?
        }
        struct ViewModel {
            var model: MoviesResponseModel?
        }
    }
}
