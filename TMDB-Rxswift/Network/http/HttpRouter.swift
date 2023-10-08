//
//  httpRouter.swift
//  TMDB-Rxswift
//
//  Created by Syed Wajahat Ali on 30/09/2023.
//

import Alamofire

protocol HttpRouter {
    var baseUrl: String { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var parameter: Parameters? { get }
    func body() -> Data?
    
    func request(usingHttpService service: HttpService) throws -> DataRequest
}

extension HttpRouter {

    func body() -> Data? {
        return nil
    }
    
    func asUrlRequest() throws -> URLRequest {
        var url = try baseUrl.asURL()
        url.appendPathComponent(path)
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpBody = body()
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.headers = headers()

        
        urlRequest = try URLEncoding.default.encode(urlRequest, with: parameter)
        
        return urlRequest
    }
    
    func headers() -> HTTPHeaders {
        var header: HTTPHeaders = [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
        
        let secretKey = Config.sharedInstance.secretKey
        header["Authorization"] = "Bearer \(secretKey)"
        
        return header
    }
    
    func request(usingHttpService service: HttpService) throws -> DataRequest {
        return try service.request(asUrlRequest())
    }
}
