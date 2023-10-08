//
//  UpcomingMoviesModel.swift
//  TMDB-Rxswift
//
//  Created by Syed Wajahat Ali on 01/10/2023.
//

import Foundation

struct UpcomingMoviesModelResponse: Codable {
    var page: Int
    var results: [UpcomingMoviesModel]
    var total_pages: Int
    var total_results: Int
    
    enum CodingKeys: String, CodingKey {
        case page = "pages"
        case results = "results"
        case total_pages = "total_pages"
        case total_results = "total_results"
    }
}

struct UpcomingMoviesModel: Codable {
    var adult: Bool
    var backdropPath: String
    var genreIds: [Int]
    var id: Int
    var originalLanguage: String
    var originalTitle: String
    var overview: String
    var popularity: Double
    var posterPath: String
    var releaseDate: Date
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

extension UpcomingMoviesModel: Hashable {
    func hash(into coder: inout Hasher) {
        coder.combine(id)
    }
}

extension UpcomingMoviesModel: Equatable {
    static func ==(lhs: UpcomingMoviesModel, rhs: UpcomingMoviesModel) -> Bool {
        return lhs.id == rhs.id
    }
}
