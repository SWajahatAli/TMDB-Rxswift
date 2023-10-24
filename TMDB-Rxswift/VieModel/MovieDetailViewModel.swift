//
//  MovieDetailViewModel.swift
//  TMDB-Rxswift
//
//  Created by Syed Wajahat Ali on 22/10/2023.
//

import Foundation

protocol MovieDetailPresentable {
    typealias Input = ()
    typealias Ouput = ()
    
    var output: MovieDetailPresentable.Ouput { get }
    var input: MovieDetailPresentable.Input { get }
}

class MovieDetailViewModel { // : MovieDetailPresentable {
//    var output: MovieDetailPresentable.Ouput
//    var input: MovieDetailPresentable.Input
    
    
}
