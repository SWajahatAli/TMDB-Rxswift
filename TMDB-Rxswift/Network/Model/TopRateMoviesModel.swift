//
//  TopRateMoviesModel.swift
//  TMDB-Rxswift
//
//  Created by Syed Wajahat Ali on 01/10/2023.
//

import Foundation

struct TopRatedMovieModelResponse: Codable {
    var page: Int
    var results: [TopRateMoviesModel]
    var totalPages: Int
    var totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page = "page"
        case results = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct TopRateMoviesModel: Codable {
    var adult: Bool
    var backdropPath: String
    var genreIds: [Int]
    var id: Int
    var originalLanguage: String
    var originalTitle: String
    var overview: String
    var popularity: Double
    var posterPath: String
    var releaseDate: String
    var title: String
    var video: Bool
    var voteAverage: Double
    var voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult = "adult"
        case backdropPath = "backdrop_path"
        case genreIds = "genre_ids"
        case id = "id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview = "overview"
        case popularity = "popularity"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title = "title"
        case video = "video"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

extension TopRateMoviesModel: Hashable {
    func hash(into coder:  inout Hasher) {
        coder.combine(id)
    }
}

extension TopRateMoviesModel: Equatable {
    static func ==(lhs: TopRateMoviesModel, rhs: TopRateMoviesModel) -> Bool {
        return lhs.id == rhs.id
    }
}
