//
//  httpService.swift
//  TMDB-Rxswift
//
//  Created by Syed Wajahat Ali on 30/09/2023.
//

import Alamofire

protocol HttpService {
    var sessionManager: Session { get }
    func request(_ urlRequest: URLRequestConvertible) -> DataRequest
}
