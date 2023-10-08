//
//  MovieCoordinator.swift
//  TMDB-Rxswift
//
//  Created by Syed Wajahat Ali on 30/09/2023.
//
import UIKit

class MovieCoordinator: BaseCoordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    override func start() {
        let view: MovieViewController = .instantiate()
        let service = MovieService.sharedInstance
        
        view.viewModelBuilder = {
            return MovieViewModel(input: $0, apiService: service)
        }
        
        navigationController.setViewControllers([view], animated: true)
    }
}
