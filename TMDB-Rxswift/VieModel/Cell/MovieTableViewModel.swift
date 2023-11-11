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
    var yearOfRelease: String { get }
    var bookmarked: Bool { get }
    var rating: Double { get }
    var description: String { get }
}

struct MovieTableViewModel: MovieTablePresentable {
    var image: String = ""
    var title: String = ""
    var yearOfRelease: String = ""
    var bookmarked: Bool = false
    var rating: Double = 0.0
    var description: String = ""
    
    init() {
        
    }
    
    init(model: MoviesModel) {
        self.image = model.posterPath
        self.title = model.title
        self.yearOfRelease = model.releaseDate
        self.bookmarked = false
        self.rating = 0.0
        self.description = model.overview
    }
}

extension MovieTableViewModel {
    func convertToPresentable(model: MoviesModel) -> MovieTablePresentable {
        return MovieTableViewModel(model: model)
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
