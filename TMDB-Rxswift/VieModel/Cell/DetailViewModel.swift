//
//  DetailViewModel.swift
//  TMDB-Rxswift
//
//  Created by Syed Wajahat Ali on 25/10/2023.
//

import Foundation
import RxCocoa
import RxSwift
import RxDataSources

typealias MovieDescriptionViewSection = SectionModel<Int, MovieDescriptionViewPresentable>

protocol MovieDescriptionViewPresentable {
    var description: String { get }
}

class MovieDescriptionViewModel: MovieDescriptionViewPresentable {
    var description: String
        
    init(usingModel model: MoviesModel) {
        self.description = model.overview
    }
}

extension MovieDescriptionViewModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(description)
    }
}

extension MovieDescriptionViewModel: Equatable {
    static func ==(lhs: MovieDescriptionViewModel, rhs: MovieDescriptionViewModel) -> Bool {
        return lhs.description == rhs.description
    }
}
