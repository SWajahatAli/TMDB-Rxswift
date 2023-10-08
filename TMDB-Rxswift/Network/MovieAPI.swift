//
//  MovieAPI.swift
//  TMDB-Rxswift
//
//  Created by Syed Wajahat Ali on 01/10/2023.
//

import RxSwift

protocol MovieAPI {
    func fetchPopularMovies() -> Single<PopularMovieModelResponse>
    func fetchUpmcomingMovies() -> Single<UpcomingMoviesModelResponse>
    func fetchTopRateMovies() -> Single<TopRatedMovieModelResponse>
}
