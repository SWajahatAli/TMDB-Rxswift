//
//  MovieAPI.swift
//  TMDB-Rxswift
//
//  Created by Syed Wajahat Ali on 01/10/2023.
//

import RxSwift

protocol MovieAPI {
    func fetchPopularMovies() -> Single<MovieModelResponse>
    func fetchUpmcomingMovies() -> Single<MovieModelResponse>
    func fetchTopRateMovies() -> Single<MovieModelResponse>
    func fetchGenreForMovies() -> Single<GenreMoveiModel>
}
