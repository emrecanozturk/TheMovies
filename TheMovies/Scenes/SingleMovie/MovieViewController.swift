//
//  MovieViewController.swift
//  Flicks
//
//  Created by Emrecan Ozturk on 4.01.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.


import UIKit

protocol MovieDisplayLogic: AnyObject {
    func displayMovie(viewModel: Movie.Models.ViewModel)
    func displayFailure(message: String)
}

class MovieViewController: UIViewController, MovieDisplayLogic {
    var interactor: MovieBusinessLogic?
    var router: (NSObjectProtocol & MovieRoutingLogic & MovieDataPassing)?
    
    @IBOutlet private weak var containerImageView: UIView!
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var centerContainerView: UIView!
    @IBOutlet private weak var movieDescriptionTextView: UITextView!
    
    var posterImageUrl: URL?
    var posterTitle: String?
    var movideID: Int?
    var movieDescription: String?
    var index: Int = 0

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
        let interactor = MovieInteractor()
        let presenter = MoviePresenter()
        let router = MovieRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    private func setupUI() {
        centerContainerView.layer.cornerRadius = 12
        centerContainerView.layer.masksToBounds = true

        centerContainerView.layer.shadowColor = UIColor.black.cgColor
        centerContainerView.layer.shadowOpacity = 10.0
        centerContainerView.layer.shadowOffset = .zero
        centerContainerView.layer.shadowRadius = 150.0
        centerContainerView.layer.masksToBounds = false
        
        posterImageView.kf.setImage(with: posterImageUrl)
        posterImageView.applyshadowWithCorner(containerView: containerImageView, cornerRadious: 10.0)
        nameLabel.text = posterTitle
        
        containerImageView.heroID = "\(index)" + "poster"
        nameLabel.heroID = "\(index)" + "title"
        centerContainerView.heroID = "\(index)"
        movieDescriptionTextView.text = movieDescription
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
        setupUI()
        getMovie()
    }
  
    // MARK: Get Movie
  
    func getMovie() {
//        let request = Movie.Models.Request(id: movideID ?? 0)
//        interactor?.getMovie(request: request)
    }
    
    // MARK: Display Movie
  
    func displayMovie(viewModel: Movie.Models.ViewModel) {
//        movieDescriptionTextView.text = viewModel.model?.overview
        posterImageUrl = URL(string: router?.dataStore.movieModel.posterPath ?? "")
        index = router?.dataStore.movieModel.index ?? 0
    }
    
    func displayFailure(message: String) {
        showAlert(withTitle: "Ops!", withMessage: "Something wrong...")
    }
    
    @IBAction func close(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
