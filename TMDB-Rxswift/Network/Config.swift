//
//  Config.swift
//  TMDB-Rxswift
//
//  Created by Syed Wajahat Ali on 30/09/2023.
//

import Foundation

class Config {
    static var sharedInstance = Config()
    
    var baseUrl: String {
        return "https://api.themoviedb.org/3"
    }
    
    var secretKey: String {
        return "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzMWI4NGRkOTExOGUwODA5YThjOGY2NmZkZDI1ZWM1MyIsInN1YiI6IjYyMWZjZjQwNDFhYWM0MDAxYjMzZWIwMyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.zjId9VqEdglAtMlqzaTIkcSz9OuwUKb4iqIXJMhljS8"
    }
}
