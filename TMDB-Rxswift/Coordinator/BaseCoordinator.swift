//
//  BaseCoordinator.swift
//  TMDB-Rxswift
//
//  Created by Syed Wajahat Ali on 30/09/2023.
//

class BaseCoordinator: Coordinator {
    var coordinators: [Coordinator] = []
    
    func start() {
        fatalError("Children should implement start() to `init`")
    }
}
