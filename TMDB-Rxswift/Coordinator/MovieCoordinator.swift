//
//  MovieCoordinator.swift
//  TMDB-Rxswift
//
//  Created by Syed Wajahat Ali on 30/09/2023.
//
import UIKit
import RxSwift
import RxCocoa

class MovieCoordinator: BaseCoordinator {
    var navigationController: UINavigationController
    private let bag = DisposeBag()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    override func start() {
        let view: MovieViewController = .instantiate()
        let service = MovieService.sharedInstance
        
        view.viewModelBuilder = { [bag] in
            let viewModel = MovieViewModel(input: $0, apiService: service)
        
            viewModel
                .router
                .movies
                .map({[weak self] models in
                    self?.showMovieDetails(usingModel: models)
                })
                .drive()
                .disposed(by: bag)
            
            return viewModel
        }
        
        navigationController.setViewControllers([view], animated: true)
    }
}

private extension MovieCoordinator {
    func showMovieDetails(usingModel: Set<MoviesModel>) {
        let movieDetailCoordinator = MovieDetailCoordinator(navigationController: navigationController)
        self.add(movieDetailCoordinator)
        
        movieDetailCoordinator.start()
    }
}
