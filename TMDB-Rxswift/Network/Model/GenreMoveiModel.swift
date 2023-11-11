//
//  Genre.swift
//  TMDB-Rxswift
//
//  Created by Syed Wajahat Ali on 04/11/2023.
//

import Foundation

struct GenreMoveiModel: Codable {
    var genres: [Genre]
    
    enum CodingKeys: String, CodingKey {
        case genres = "genres"
    }
    
}

struct Genre: Codable {
    var id: Int
    var name: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }
}
 
