//
//  MovieTableViewModel.swift
//  TMDB-Rxswift
//
//  Created by Syed Wajahat Ali on 08/10/2023.
//

import Foundation
import RxDataSources

typealias MovieItemsSection = SectionModel<Int, MovieTablePresentable>

protocol MovieTablePresentable {
    var image: String { get }
    var title: String { get }
    var yearOfRelease: Int { get }
    var bookmarked: Bool { get }
    var rating: Double { get }
    var description: String { get }
}

struct MovieTableViewModel: MovieTablePresentable {
    var image: String = ""
    var title: String = ""
    var yearOfRelease: Int = 0
    var bookmarked: Bool = false
    var rating: Double = 0.0
    var description: String = ""
    
    init(model: MoviesModel) {
        
    }
}

extension MovieTableViewModel: Hashable {
    func hash(into coder: inout Hasher) {
        coder.combine(title)
    }
}

extension MovieTableViewModel: Equatable {
    static func ==(lhs: MovieTableViewModel, rhs: MovieTableViewModel) -> Bool {
        return lhs.title == rhs.title
    }
}
