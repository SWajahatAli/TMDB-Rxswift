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
import RxDataSources

protocol MoviePresentable {
    typealias Input = (popularButtonTap: Observable<Void>, upcomingButtonTap: Observable<Void>, topRateButtonTap: Observable<Void>)
    typealias Ouput = (popularMoviesModel: Observable<[MovieItemsSection]>, upcomingMoviesModel: Observable<[MovieItemsSection]>, topRateMoviesModel: Observable<[MovieItemsSection]>)

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

    // Define a computed property to access the observable
    typealias PopularMovieTypeState = (movieType: BehaviorRelay<Set<MoviesModel>>, ())
    fileprivate var popularMovieTypeState: PopularMovieTypeState = (movieType: BehaviorRelay<Set<MoviesModel>>(value: []), ())
    
    typealias UpcomingMovieTypeState = (upcomingMovie: BehaviorRelay<Set<MoviesModel>>, ())
    fileprivate var upcomingMovieTypeState: UpcomingMovieTypeState = (upcomingMovie: BehaviorRelay<Set<MoviesModel>>(value: Set<MoviesModel>()), ())
    
    typealias TopRatedMovieTypeState = (topRateMovie: BehaviorRelay<Set<MoviesModel>>, ())
    fileprivate var topRatedMovieTypeState: TopRatedMovieTypeState = (topRateMovie: BehaviorRelay<Set<MoviesModel>>(value: Set<MoviesModel>()), ())
    
    let fetchPopularMovies: Observable<[MovieItemsSection]>
    let fetchUpcomingMovies: Observable<[MovieItemsSection]>
    let fetchTopRatedMovies: Observable<[MovieItemsSection]>
    
    init(input: MoviePresentable.Input, apiService: MovieAPI) {
        self.input = input
        
        fetchPopularMovies = MovieViewModel.fetchPopuluarMovies(bag: bag, input: input, apiService: apiService, state: popularMovieTypeState)
        
        fetchUpcomingMovies = MovieViewModel.fetchUpcomingMovies(bag: bag, input: input, apiService: apiService, state: upcomingMovieTypeState)
        
        fetchTopRatedMovies = MovieViewModel.topRateMovies(bag: bag, input: input, apiService: apiService, state: topRatedMovieTypeState)
        
        self.output = (popularMoviesModel: fetchPopularMovies, upcomingMoviesModel: fetchUpcomingMovies, topRateMoviesModel: fetchTopRatedMovies)
        self.apiService = apiService
        
        _ = self.process(apiService: apiService, state: popularMovieTypeState)
    }
}

extension MovieViewModel {
    func process(apiService: MovieAPI, state: PopularMovieTypeState) -> Observable<[MovieItemsSection]> {
        _ = input.popularButtonTap
            .flatMapLatest({ _ in
                return apiService.fetchPopularMovies()
                    .map({ Set($0.results) })
                    .asDriver(onErrorJustReturn: Set<MoviesModel>())
            })
            .asObservable()
            .bind(to: state.movieType)
            .disposed(by: bag)
        
        return state.movieType.compactMap {
            $0.map {
                MovieTableViewModel().convertToPresentable(model: $0)
            }
        }
        .map { movieTablePresentable in
            return [MovieItemsSection(model: 0, items: movieTablePresentable)]
        }
    }
}

extension MovieViewModel {
    static func fetchPopuluarMovies(bag: DisposeBag, input: MovieViewModel.Input, apiService: MovieAPI, state: PopularMovieTypeState) -> Observable<[MovieItemsSection]> {
        _ = input.popularButtonTap
            .flatMapLatest({ _ in
                return apiService.fetchPopularMovies()
                    .map({ Set($0.results) })
                    .asDriver(onErrorJustReturn: Set<MoviesModel>())
            })
            .asObservable()
            .bind(to: state.movieType)
            .disposed(by: bag)
        
        return state.movieType.compactMap {
            $0.map {
                MovieTableViewModel().convertToPresentable(model: $0)
            }
        }
        .map { movieTablePresentable in
            return [MovieItemsSection(model: 0, items: movieTablePresentable)]
        }
    }
    
    static func fetchUpcomingMovies(bag: DisposeBag, input: MovieViewModel.Input, apiService: MovieAPI, state: UpcomingMovieTypeState) -> Observable<[MovieItemsSection]> {
        
        _ = input.upcomingButtonTap
            .flatMapLatest { _ in
                return apiService
                    .fetchUpmcomingMovies()
                    .map({ Set($0.results) })
                    .asDriver(onErrorJustReturn: Set<MoviesModel>())
            }
            .asObservable()
            .bind(to: state.upcomingMovie)
            .disposed(by: bag)
        
        return state.upcomingMovie.compactMap {
            $0.map {
                MovieTableViewModel().convertToPresentable(model: $0)
            }
        }
        .map { movieTablePresentable in
            return [MovieItemsSection(model: 0, items: movieTablePresentable)]
        }
    }
    
    static func topRateMovies(bag: DisposeBag, input: MovieViewModel.Input, apiService: MovieAPI, state: TopRatedMovieTypeState) -> Observable<[MovieItemsSection]> {
        
        _ = input.topRateButtonTap
            .flatMapLatest { _ in
                return apiService.fetchTopRateMovies()
                    .map { Set($0.results) }
                    .asDriver(onErrorJustReturn: [])
            }
            .asObservable()
            .bind(to: state.topRateMovie)
            .disposed(by: bag)
        
        return state.topRateMovie.compactMap {
            $0.compactMap {
                MovieTableViewModel().convertToPresentable(model: $0)
            }
        }
        .map { movieModelPresentable in
            return [MovieItemsSection(model: 0, items: movieModelPresentable)]
        }
    }
}
