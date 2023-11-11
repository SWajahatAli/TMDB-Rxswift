//
//  ImageViewModel.swift
//  TMDB-Rxswift
//
//  Created by Syed Wajahat Ali on 25/10/2023.
//

import Foundation
import RxDataSources

typealias ImageViewSection = SectionModel<Int, ImageViewPresentable>

protocol ImageViewPresentable {
    var image: String { get }
}

class ImageViewModel: ImageViewPresentable {
    var image: String
        
    init(usingModel model: MoviesModel) {
        self.image = model.posterPath
    }
}

extension ImageViewModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(image)
    }
}

extension ImageViewModel: Equatable {
    static func ==(lhs: ImageViewModel, rhs: ImageViewModel) -> Bool {
        return lhs.image == rhs.image
    }
}
