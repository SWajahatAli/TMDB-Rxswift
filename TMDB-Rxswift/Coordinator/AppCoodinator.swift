//
//  AppCoodinator.swift
//  TMDB-Rxswift
//
//  Created by Syed Wajahat Ali on 30/09/2023.
//

import UIKit

class AppCoodinator: BaseCoordinator {
    
    var window: UIWindow
    var navigationController: UINavigationController = {
        let navigationController = UINavigationController()
        navigationController.navigationBar.prefersLargeTitles = true

        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor.black
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        let navigationBar = navigationController.navigationBar
        navigationBar.tintColor = .white
        
        navigationBar.compactAppearance = appearance
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
        
        return navigationController
    }()
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() {
        let coordinator = MovieCoordinator(navigationController: navigationController)
        coordinators.append(coordinator)
        coordinator.start()
        
        self.window.rootViewController = navigationController
        self.window.makeKeyAndVisible()
    }
}
