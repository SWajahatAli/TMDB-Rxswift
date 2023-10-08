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
    typealias Ouput = (popularMoviesModel: Observable<PopularMovieModelResponse>, upcomingMoviesModel: Observable<UpcomingMoviesModelResponse>, topRateMoviesModel: Observable<TopRatedMovieModelResponse>)
//    typealias Ouput = (topRateMoviesModel: Observable<TopRatedMovieModelResponse>, ())

    typealias ViewModelBuilder = (MoviePresentable.Input) -> MoviePresentable
    
    var input: MoviePresentable.Input { get }
    var output: MoviePresentable.Ouput { get }
}

class MovieViewModel: MoviePresentable {
    var input: MoviePresentable.Input
    var output: MoviePresentable.Ouput
    
    private(set) var apiService: MovieAPI
    
    typealias PopularMoviesState = (popularMovies: BehaviorRelay<Set<PopularMoviesModel>>, ())
    fileprivate var popularState:PopularMoviesState = (popularMovies: BehaviorRelay<Set<PopularMoviesModel>>(value: []), ())
    
    typealias TopRateMoviesState = (topRatedMovies: BehaviorRelay<Set<TopRateMoviesModel>>, ())
    fileprivate var topRatedState:TopRateMoviesState = (topRatedMovies: BehaviorRelay<Set<TopRateMoviesModel>>(value: []), ())
    
    typealias UpcomingMoviesState = (upcomingMovies: BehaviorRelay<Set<UpcomingMoviesModel>>, ())
    fileprivate var upcomingState:UpcomingMoviesState = (upcomingMovies: BehaviorRelay<Set<UpcomingMoviesModel>>(value: []), ())
    

    let bag = DisposeBag() // It is something that is reponsible to deallocate all the observables whenever struct/class deinits
    
    init(input: MoviePresentable.Input, apiService: MovieAPI) {
        self.input = input
        
        let popularBtnTapObservable = input.popularButtonTap
                        .flatMapLatest { _ in
                            return apiService.fetchPopularMovies()
                                .asObservable()
                        }
        
        let upcomingBtnTapObservable = input.upcomingButtonTap
                        .flatMapLatest { _ in
                            return apiService.fetchUpmcomingMovies()
                                .asObservable()
                        }
        
        let topRatedBtnTapObservable = input.topRateButtonTap
                        .flatMapLatest { _ in
                            return apiService.fetchTopRateMovies()
                                .asObservable()
                    }
        
        self.output = (popularMoviesModel: popularBtnTapObservable, upcomingMoviesModel: upcomingBtnTapObservable, topRateMoviesModel: topRatedBtnTapObservable)
        
        self.apiService = apiService
//        self.process()
    }
}

