//
//  MovieDetailCoordinator.swift
//  TMDB-Rxswift
//
//  Created by Syed Wajahat Ali on 22/10/2023.
//

import UIKit

class MovieDetailCoordinator: BaseCoordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    override func start() {
        let movieDetailViewController: MovieDetailViewController = .instantiate()
        
        navigationController.pushViewController(movieDetailViewController, animated: true)
    }
}
