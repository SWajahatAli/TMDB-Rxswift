//
//  PopularModelModels.swift
//  TMDB-Rxswift
//
//  Created by Syed Wajahat Ali on 01/10/2023.
//
import Foundation

struct MovieModelResponse: Codable {
    var page: Int
    var results: [MoviesModel]
    var totalPages: Int
    var totalResults: Int

    enum CodingKeys: String, CodingKey  {
        case page = "page"
        case results = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct MoviesModel: Codable {
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

    init() {
        self.adult = false
        self.backdropPath = ""
        self.genreIds = []
        self.id = 0
        self.originalLanguage = ""
        self.originalTitle = ""
        self.overview = ""
        self.popularity = 0
        self.posterPath = ""
        self.releaseDate = ""
        self.title = ""
        self.video = false
        self.voteAverage = 0
        self.voteCount = 0
    }

    init?(fromArray from: [MoviesModel]) {
        guard let firstMovie = from.first else {
            return nil
        }

        self.adult = firstMovie.adult
        self.backdropPath = firstMovie.backdropPath
        self.genreIds = firstMovie.genreIds
        self.id = firstMovie.id
        self.originalLanguage = firstMovie.originalLanguage
        self.originalTitle = firstMovie.originalTitle
        self.overview = firstMovie.overview
        self.popularity = firstMovie.popularity
        self.posterPath = firstMovie.posterPath
        self.releaseDate = firstMovie.releaseDate
        self.title = firstMovie.title
        self.video = firstMovie.video
        self.voteAverage = firstMovie.voteAverage
        self.voteCount = firstMovie.voteCount

    }
}

extension MoviesModel: Hashable {
    func hasher(into coder: inout Hasher) {
        coder.combine(id)
    }
}

extension MoviesModel: Equatable {
    static func ==(lhs: MoviesModel, rhs: MoviesModel) -> Bool {
        return lhs.id == rhs.id
    }
}
