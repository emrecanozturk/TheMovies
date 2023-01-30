//
//  MoviesViewController.swift
//  TheMovies
//
//  Created by zodiac on 30.01.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol MoviesDisplayLogic: AnyObject {
    func displayMovies(viewModel: Movies.Models.ViewModel)
    func displayFailure(message: String)
}

class MoviesViewController: UIViewController, MoviesDisplayLogic {
    var interactor: MoviesBusinessLogic?
    var router: (NSObjectProtocol & MoviesRoutingLogic & MoviesDataPassing)?
    
    private var tableViewDataSource: MoviesTableViewDataSource!
    private var tableViewDelegate: MoviesTableViewDelegate!
    
    private var page: Int = 0
    private var totalPageCount: Int = 0
    private var maxPageCount: Int = 0

    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Object lifecycle
  
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
  
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
  
    // MARK: Setup
  
    private func setup() {
        let viewController = self
        let interactor = MoviesInteractor()
        let presenter = MoviesPresenter()
        let router = MoviesRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
  
    // MARK: Routing
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
  
    // MARK: View lifecycle
  
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewSetup()
        getMovies()
    }
  
    // MARK: UI configuration
    
    private func tableViewSetup() {
        tableViewDataSource = MoviesTableViewDataSource(tableView: tableView)
        tableViewDelegate = MoviesTableViewDelegate()
        tableViewDelegate.presentingController = self
        tableView.dataSource = tableViewDataSource
        tableView.delegate = tableViewDelegate
    }
    
    // MARK: Get datas from api
  
    func getMovies() {
        page += 1
        let request = Movies.Models.Request(page: page)
        interactor?.getMovies(request: request)
    }
  
    // MARK: Display datas
    
    func displayMovies(viewModel: Movies.Models.ViewModel) {
        if let results = viewModel.model?.results, let movies = tableViewDataSource.movies {
            tableViewDataSource.movies?.results?.append(contentsOf: results)
            totalPageCount = totalPageCount + results.count
            maxPageCount = movies.totalPages ?? 0
        } else {
            tableViewDataSource.movies = viewModel.model
            totalPageCount = viewModel.model?.results?.count ?? 0
            maxPageCount = viewModel.model?.totalPages ?? 0
        }
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    func displayFailure(message: String) {
        showAlert(withTitle: "Ops!", withMessage: "Something wrong...")
    }
}

extension MoviesViewController: MoviesPresenting {
    
    func currentSelected(_ index: Int) {
//        presentMovieDetail(index: index)
    }
    
    func willDisplayCell(_ index: Int) {
        if index == totalPageCount - 1 && index + 1 != maxPageCount {
            getMovies()
        }
    }
    
}
