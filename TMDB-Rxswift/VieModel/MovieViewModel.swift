//
//  MovieViewModel.swift
//  TMDB-Rxswift
//
//  Created by Syed Wajahat Ali on 30/09/2023.
//

import RxSwift
import RxCocoa
import Alamofire
import Foundation
import UIKit
import SwiftUI

protocol MoviePresentable {
    typealias Input = (popularButtonTap: Observable<Void>, upcomingButtonTap: Observable<Void>, topRateButtonTap: Observable<Void>)
    typealias Ouput = (popularMoviesModel: Observable<[MoviesModel]>, upcomingMoviesModel: Observable<[MoviesModel]>, topRateMoviesModel: Observable<[MoviesModel]>)

    typealias ViewModelBuilder = (MoviePresentable.Input) -> MoviePresentable
    
    var input: MoviePresentable.Input { get }
    var output: MoviePresentable.Ouput { get }
}

class MovieViewModel: MoviePresentable {
    var input: MoviePresentable.Input
    var output: MoviePresentable.Ouput
    
    private(set) var apiService: MovieAPI
    private var movieResponseModel = MovieModelResponse.init(page: 0, results: [], totalPages: 0, totalResults: 0)
    
    let bag = DisposeBag() // It is something that is reponsible to deallocate all the observables whenever struct/class deinits
    
    let fetchPopularMovies: Observable<[MoviesModel]>
    let fetchUpcomingMovies: Observable<[MoviesModel]>
    let fetchTopRatedMovies: Observable<[MoviesModel]>
    
    init(input: MoviePresentable.Input, apiService: MovieAPI) {
        self.input = input
        
        fetchPopularMovies = input.popularButtonTap
            .flatMapLatest({ _ in
                return apiService.fetchPopularMovies()
                    .map { $0.results }
                    .asDriver(onErrorJustReturn: [])
            })
            .asDriver(onErrorJustReturn: [])
            .asObservable()
    
        fetchUpcomingMovies = input.upcomingButtonTap
            .flatMapLatest { _ in
                return apiService.fetchUpmcomingMovies()
                        .map { $0.results }
                        .asDriver(onErrorJustReturn: [])
            }
            .asDriver(onErrorJustReturn: [])
            .asObservable()
        
        fetchTopRatedMovies = input.topRateButtonTap
            .flatMapLatest { _ in
                return apiService.fetchTopRateMovies()
                    .map { $0.results }
                    .asDriver(onErrorJustReturn: [])
            }
            .asDriver(onErrorJustReturn: [])
            .asObservable()
        
        self.output = (popularMoviesModel: fetchPopularMovies, upcomingMoviesModel: fetchUpcomingMovies, topRateMoviesModel: fetchTopRatedMovies)
        self.apiService = apiService
    }
}

