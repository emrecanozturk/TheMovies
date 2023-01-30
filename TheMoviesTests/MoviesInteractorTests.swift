//
//  MoviesInteractorTests.swift
//  TheMovies
//
//  Created by zodiac on 30.01.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

@testable import TheMovies
import XCTest

class MoviesInteractorTests: XCTestCase {
    // MARK: Subject under test
  
    var sut: MoviesInteractor!
  
    // MARK: Test lifecycle
  
    override func setUp() {
        super.setUp()
        setupMoviesInteractor()
    }
  
    override func tearDown() {
        super.tearDown()
    }
  
    // MARK: Test setup
  
    func setupMoviesInteractor() {
        sut = MoviesInteractor()
    }
  
    // MARK: Test doubles
  
    class MoviesPresentationLogicSpy: MoviesPresentationLogic {
        var presentLoadingCalled: Bool = false
        func presentLoading() {
            presentLoadingCalled = true
        }
        
        var presentMoviesCalled: Bool = false
        func presentMovies(response: TheMovies.Movies.Models.Response) {
            presentMoviesCalled = true
        }
        
        func presentFailure(message: String) {
            presentMoviesCalled = true
        }
    }
  
    // MARK: Tests
  
    func testDoSomething() {
        // Given
        let spy = MoviesPresentationLogicSpy()
        sut.presenter = spy
        let request = Movies.Models.Request(page: 0)
    
        // When
        sut.getMovies(request: request)
    
        // Then
        XCTAssertTrue(spy.presentLoadingCalled, "doSomething(request:) should ask the presenter to format the result")
    }
}
