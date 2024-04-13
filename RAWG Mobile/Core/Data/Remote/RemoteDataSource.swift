//
//  RemoteDataSource.swift
//  RAWG Mobile
//
//  Created by Naufal Abiyyu on 13/03/24.
//

import Foundation
import Alamofire
import Combine

protocol RemoteDataSourceProtocol: AnyObject {
    
    func getTopPicksGame() -> AnyPublisher<[TopPickResponse], Error>
    
    func getTrendingGame() -> AnyPublisher<[TrendingResponse], Error>
    
    func getDetailGame(by id: Int) -> AnyPublisher<DetailResponse, Error>
    
    func searchGame(by name: String) -> AnyPublisher<[TopPickResponse], Error>
}

final class RemoteDataSource: NSObject {
    
    private override init() { }
    
    static let sharedInstance: RemoteDataSource = RemoteDataSource()
}

extension RemoteDataSource: RemoteDataSourceProtocol {
    
    func getTopPicksGame() -> AnyPublisher<[TopPickResponse], any Error> {
        return Future<[TopPickResponse], Error> { completion in
            if let url = URL(string: Endpoints.Gets.topPicks.url) {
                AF.request(url)
                    .validate()
                    .responseDecodable(of: TopPicksResponse.self) { response in
                        switch response.result {
                        case .success(let value):
                            completion(.success(value.results))
                            debugPrint(value.results)
                        case .failure:
                            completion(.failure(URLError.invalidResponse))
                        }
                    }
            }
        }.eraseToAnyPublisher()
    }
    
    func getTrendingGame() -> AnyPublisher<[TrendingResponse], any Error> {
        return Future<[TrendingResponse], Error> { completion in
            if let url = URL(string: Endpoints.Gets.trending.url) {
                AF.request(url)
                    .validate()
                    .responseDecodable(of: TrendingsResponse.self) { response in
                        switch response.result {
                        case .success(let value):
                            completion(.success(value.results))
                        case .failure:
                            completion(.failure(URLError.invalidResponse))
                        }
                    }
            }
        }.eraseToAnyPublisher()
    }
    
    func getDetailGame(by id: Int) -> AnyPublisher<DetailResponse, any Error> {
        return Future<DetailResponse, Error> { completion in
            if let url = URL(string: Endpoints.Gets.gameDetail(id).url) {
                AF.request(url)
                    .validate()
                    .responseDecodable(of: DetailResponse.self) { response in
                        switch response.result {
                        case .success(let value):
                            completion(.success(value.self))
                        case .failure:
                            completion(.failure(URLError.invalidResponse))
                        }
                    }
            }
        }.eraseToAnyPublisher()
    }
    
    func searchGame(by name: String) -> AnyPublisher<[TopPickResponse], any Error> {
        return Future<[TopPickResponse], Error> { completion in
            if let url = URL(string: Endpoints.Gets.searchGames.url + name) {
                AF.request(url)
                    .validate()
                    .responseDecodable(of: TopPicksResponse.self) { response in
                        switch response.result {
                        case .success(let value):
                            completion(.success(value.results))
                        case .failure:
                            completion(.failure(URLError.invalidResponse))
                        }
                    }
            }
        }.eraseToAnyPublisher()
    }
    
    
}
