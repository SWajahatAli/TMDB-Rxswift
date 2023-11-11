//
//  MovieService.swift
//  TMDB-Rxswift
//
//  Created by Syed Wajahat Ali on 01/10/2023.
//

import RxSwift
import RxCocoa

class MovieService {
    let httpService: MovieHttpService = MovieHttpService()
    static let sharedInstance: MovieService = MovieService()
}

extension MovieService: MovieAPI {
    func fetchPopularMovies() -> Single<MovieModelResponse> {
        return Single.create { (single) -> Disposable in
            do {
                let request = try MovieRouter.getPopularMovies.request(usingHttpService: self.httpService)
                request.responseDecodable(of: MovieModelResponse.self) { response in
                    guard let data = response.data else { return }
                    
                    do {
                        let responseData = try JSONDecoder().decode(MovieModelResponse.self, from: data)
                        single(.success(responseData))
                    } catch(let err) {
                        print(err)
                        single(.failure(err))
                    }
                }
            } catch(let err) {
                print(err)
                single(.failure(err))
            }
            
            return Disposables.create()
        }
    }
    
    func fetchTopRateMovies() -> Single<MovieModelResponse> {
        return Single.create { (single) -> Disposable in
            do {
                let request = try MovieRouter.getTopRatedMovies.request(usingHttpService: self.httpService)
                request.responseDecodable(of: MovieModelResponse.self) { response in
                    guard let data = response.data else { return }
                    
                    do {
                        let responseData = try JSONDecoder().decode(MovieModelResponse.self, from: data)
                        single(.success(responseData))
                    } catch(let error) {
                        print(error)
                        single(.failure(error))
                    }
                }
            } catch(let error) {
                print(error)
                single(.failure(error))
            }
            
            return Disposables.create()
        }
    }
    
    func fetchUpmcomingMovies() -> Single<MovieModelResponse> {
        return Single.create { (single) -> Disposable in
            
            do {
                
                let request = try MovieRouter.getUpcomingMovies.request(usingHttpService: self.httpService)
                request.responseDecodable(of: MovieModelResponse.self) { response in
                    guard let data = response.data else { return }
                    
                    do {
                        let responseData = try JSONDecoder().decode(MovieModelResponse.self, from: data)
                        single(.success(responseData))
                    } catch(let error) {
                        print(error)
                        single(.failure(error))
                    }
                }
            } catch(let error) {
                print(error)
                single(.failure(error))
            }
            
            return Disposables.create()
        }
    }
    
    func fetchGenreForMovies() -> Single<GenreMoveiModel> {
        return Single.create { (single) -> Disposable in
            
            do {
                
                let request = try MovieRouter.getGenreMovie.request(usingHttpService: self.httpService)
                request.responseDecodable(of: GenreMoveiModel.self) { response in
                    guard let data = response.data else { return }
                    
                    do {
                        let responseData = try JSONDecoder().decode(GenreMoveiModel.self, from: data)
                        single(.success(responseData))
                    } catch(let error) {
                        single(.failure(error))
                    }
                }
            } catch(let error) {
                single(.failure(error))
            }
        
            
            return Disposables.create()
        }
    }
}
