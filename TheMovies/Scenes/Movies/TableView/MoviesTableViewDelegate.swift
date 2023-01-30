//
//  MoviesTableViewDelegate.swift
//  TheMovies
//
//  Created by zodiac on 30.01.2023.
//

import Foundation
import UIKit

protocol MoviesPresenting: AnyObject {
    func currentSelected(_ index: Int)
    func willDisplayCell(_ index: Int)
}

class MoviesTableViewDelegate: NSObject, UITableViewDelegate {
    
    var presentingController: MoviesPresenting?
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presentingController?.currentSelected(indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        presentingController?.willDisplayCell(indexPath.row)
    }
}
