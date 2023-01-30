//
//  MoviesWorkerTests.swift
//  TheMovies
//
//  Created by zodiac on 30.01.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

@testable import TheMovies
import XCTest

class MoviesWorkerTests: XCTestCase {
    // MARK: Subject under test
  
    var sut: MoviesWorker!
  
    // MARK: Test lifecycle
  
    override func setUp() {
        super.setUp()
        setupMoviesWorker()
    }
  
    override func tearDown() {
        super.tearDown()
    }
  
    // MARK: Test setup
  
    func setupMoviesWorker() {
        sut = MoviesWorker()
    }
  
    // MARK: Test doubles
  
    // MARK: Tests
  
    func testSomething() {
        // Given
    
        // When
    
        // Then
    }
}
