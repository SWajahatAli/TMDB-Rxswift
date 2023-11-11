//
//  RatingViewModel.swift
//  TMDB-Rxswift
//
//  Created by Syed Wajahat Ali on 25/10/2023.
//

import Foundation
import RxCocoa
import RxSwift
import RxDataSources

typealias RatingViewSection = SectionModel<Int, RatingViewPresentable>

protocol RatingViewPresentable {
    var image: String { get }
}

class RatingViewModel: ImageViewPresentable {
    var image: String
        
    init(usingModel model: MoviesModel) {
        self.image = model.posterPath
    }
}

extension RatingViewModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(image)
    }
}

extension RatingViewModel: Equatable {
    static func ==(lhs: RatingViewModel, rhs: RatingViewModel) -> Bool {
        return lhs.image == rhs.image
    }
}
