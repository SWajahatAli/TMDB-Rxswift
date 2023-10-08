//
//  MovieService.swift
//  TMDB-Rxswift
//
//  Created by Syed Wajahat Ali on 01/10/2023.
//
import Alamofire

class MovieHttpService: HttpService {
    var sessionManager: Alamofire.Session = .default
    
    func request(_ urlRequest: Alamofire.URLRequestConvertible) -> Alamofire.DataRequest {
        return sessionManager.request(urlRequest).validate(statusCode: 200..<400)
    }
}
