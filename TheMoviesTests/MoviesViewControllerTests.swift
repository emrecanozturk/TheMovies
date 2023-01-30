//
//  MoviesViewControllerTests.swift
//  TheMovies
//
//  Created by zodiac on 30.01.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.

@testable import TheMovies
import XCTest

class MoviesViewControllerTests: XCTestCase {
    // MARK: Subject under test
  
    var sut: MoviesViewController!
    var window: UIWindow!
  
    // MARK: Test lifecycle
  
    override func setUp() {
        super.setUp()
        window = UIWindow()
        setupMoviesViewController()
    }
  
    override func tearDown() {
        window = nil
        super.tearDown()
    }
  
    // MARK: Test setup
  
    func setupMoviesViewController() {
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "Movies", bundle: bundle)
        sut = storyboard.instantiateViewController(withIdentifier: "MoviesViewController") as! MoviesViewController
    }
  
    func loadView() {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }
  
    // MARK: Test doubles
  
    class MoviesBusinessLogicSpy: MoviesBusinessLogic {
        var loadRepositoriesCalled = false
        func getMovies(request: TheMovies.Movies.Models.Request) {
            loadRepositoriesCalled = true
        }
        
        func setMovies(index: Int, model: TheMovies.MovieResponseModel?) {}

    }
  
    // MARK: Tests
  
    func testShouldDoSomethingWhenViewIsLoaded() {
        // Given
        let spy = MoviesBusinessLogicSpy()
        sut.interactor = spy
    
        // When
        loadView()
    
        // Then
        XCTAssertTrue(spy.loadRepositoriesCalled, "viewDidLoad() should ask the interactor to do something")
    }
  
    func testDisplayMovies() {
        // Given
        let viewModel = Movies.Models.ViewModel(model: MoviesResponseModel(totalPages: 0, totalResults: 0, results: nil))
        // When
        loadView()
        sut.displayMovies(viewModel: viewModel)
    
        // Then
        XCTAssertTrue(sut.tableView.visibleCells.count == 0, "Total pages and total results should trigger tableView with zero cell count")
    }
}
