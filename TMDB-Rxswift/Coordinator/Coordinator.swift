//
//  Coordinator.swift
//  TMDB-Rxswift
//
//  Created by Syed Wajahat Ali on 30/09/2023.
//

protocol Coordinator: AnyObject {
    var coordinators: [Coordinator] { get set }
    
    func start()
}

extension Coordinator {
    func add(_ coordinator: Coordinator) -> Void {
        self.coordinators.append(coordinator)
    }
    
    func remove(_ coordinator: Coordinator) {
        let _ = self.coordinators.filter({ $0 !== coordinator })
    }
}
