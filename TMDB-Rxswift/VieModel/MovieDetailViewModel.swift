//
//  MovieDetailViewModel.swift
//  TMDB-Rxswift
//
//  Created by Syed Wajahat Ali on 22/10/2023.
//

import Foundation
import RxSwift
import RxCocoa

protocol MovieDetailPresentable {
    typealias Input = ((), ())
    typealias Output = (populateImageViewCell: Observable<[ImageViewSection]>, populateRatingViewCell: Observable<[RatingViewSection]>, movieDescriptionViewCell: Observable<[MovieDescriptionViewPresentable]>)
    
    var output: MovieDetailPresentable.Output { get }
    var input: MovieDetailPresentable.Input { get }
    
    typealias ViewModelBuilder = (MovieDetailPresentable.Input) -> MovieDetailPresentable
}

class MovieDetailViewModel: MovieDetailPresentable {

    var input: MovieDetailViewModel.Input
    var output: MovieDetailViewModel.Output
    
    
    init(input: MovieDetailViewModel.Input, output: MovieDetailViewModel.Output) {
        self.input = input
        self.output = output
    }
}

extension MovieDetailViewModel {
//    func output() -> MoviePresentable.Ouput {
//        
//    }
}
