//
//  MovieRouter.swift
//  TMDB-Rxswift
//
//  Created by Syed Wajahat Ali on 30/09/2023.
//

import Alamofire

enum MovieRouter {
    case getPopularMovies
    case getTopRatedMovies
    case getUpcomingMovies
    case getGenreMovie
}

extension MovieRouter: HttpRouter {
    
    var baseUrl: String {
        return Config.sharedInstance.baseUrl
    }
    
    var path: String {
        switch self {
        case .getUpcomingMovies, .getTopRatedMovies, .getPopularMovies:
            return "/discover/movie"
        case .getGenreMovie:
        return "genre/movie/list"
        }
    }
    
    var parameter: Alamofire.Parameters? {
        switch self {
            case .getPopularMovies:
                return [
                    "include_adult": false,
                    "include_video": false,
                    "language": "en-US",
                    "page": 1,
                    "sort_by": "popularity.desc"
                ]
            case .getTopRatedMovies:
                return [
                    "include_adult": false,
                    "include_video": false,
                    "language": "en-US",
                    "page": 1,
                    "sort_by": "vote_average.desc",
                    "without_genres": (99,10755),
                    "vote_count.gte": 200
                ]
            case .getUpcomingMovies:
                return [
                    "include_adult": false,
                    "include_video": false,
                    "language":"en-US",
                    "page": 1,
                    "sort_by":"popularity.desc",
                    "with_release_type": "2|3",
                    "release_date.gte": "", // min_date,
                    "release_date.lte": "", // max_date
                ]
            case .getGenreMovie:
                return [
                    "language":"en-US"
                ]
        }
    }
    
    var httpMethod: Alamofire.HTTPMethod {
        switch self {
        case .getPopularMovies, .getTopRatedMovies, .getUpcomingMovies, .getGenreMovie:
            return .get
        }
    }
}
