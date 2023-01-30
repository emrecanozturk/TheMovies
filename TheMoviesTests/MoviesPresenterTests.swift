//
//  MoviesPresenterTests.swift
//  TheMovies
//
//  Created by zodiac on 30.01.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

@testable import TheMovies
import XCTest

class MoviesPresenterTests: XCTestCase {
    // MARK: Subject under test
  
    var sut: MoviesPresenter!
  
    // MARK: Test lifecycle
  
    override func setUp() {
        super.setUp()
        setupMoviesPresenter()
    }
  
    override func tearDown() {
        super.tearDown()
    }
  
    // MARK: Test setup
  
    func setupMoviesPresenter() {
        sut = MoviesPresenter()
    }
  
    // MARK: Test doubles
  
    class MoviesDisplayLogicSpy: MoviesDisplayLogic {
        var displayMoviesCalled = false
        func displayMovies(viewModel: TheMovies.Movies.Models.ViewModel) {
            displayMoviesCalled = true
        }
        
        func displayFailure(message: String) {
            
        }
    }
  
    // MARK: Tests
  
    func testPresentSomething() {
        // Given
        let spy = MoviesDisplayLogicSpy()
        sut.viewController = spy
        let response = Movies.Models.Response()
    
        // When
        sut.presentMovies(response: response)
    
        // Then
        XCTAssertTrue(spy.displayMoviesCalled, "presentSomething(response:) should ask the view controller to display the result")
    }
}
