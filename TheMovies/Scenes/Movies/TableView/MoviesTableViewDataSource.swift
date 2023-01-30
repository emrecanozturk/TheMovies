//
//  MoviesTableViewDataSource.swift
//  TheMovies
//
//  Created by zodiac on 30.01.2023.
//

import Foundation
import UIKit
import Kingfisher

class MoviesTableViewDataSource: NSObject, UITableViewDataSource {
    
    private var tableView: UITableView
    public var movies    : MoviesResponseModel? = nil
    
    init(tableView: UITableView) {
        self.tableView = tableView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as! MovieTableViewCell

        cell.setup(title     : movies?.results?[indexPath.row].name,
                   rate      : movies?.results?[indexPath.row].voteAverage?.description,
                   date      : movies?.results?[indexPath.row].firstAirDate,
                   posterPath: movies?.results?[indexPath.row].fullPosterPath,
                   index: indexPath.row)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies?.results?.count ?? 0
    }
    
}

