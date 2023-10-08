//
//  PopularModelModels.swift
//  TMDB-Rxswift
//
//  Created by Syed Wajahat Ali on 01/10/2023.
//

import Foundation

struct PopularMovieModelResponse: Codable {
    var page: Int
    var results: [PopularMoviesModel]
    var totalPages: Int
    var totalResults: Int
    
    enum CodingKeys: String, CodingKey  {
        case page = "page"
        case results = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct PopularMoviesModel: Codable {
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

extension PopularMoviesModel: Hashable {
    func hasher(into coder: inout Hasher) {
        coder.combine(id)
    }
}

extension PopularMoviesModel: Equatable {
    static func ==(lhs: PopularMoviesModel, rhs: PopularMoviesModel) -> Bool {
        return lhs.id == rhs.id
    }
}
