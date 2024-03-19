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
    
    func getListOfGames() -> AnyPublisher<[GameResponse], Error>
    
    func getListOfGamesTopPicks() -> AnyPublisher<[GameResponse], Error>
    
    func getDetailGame(by id: Int) -> AnyPublisher<DetailResponse, Error>
    
    func searchGame(by name: String) -> AnyPublisher<[GameResponse], Error>
}

final class RemoteDataSource: NSObject {
    
    private override init() { }
    
    static let sharedInstance: RemoteDataSource = RemoteDataSource()
}

extension RemoteDataSource: RemoteDataSourceProtocol {
    
    func getListOfGames() -> AnyPublisher<[GameResponse], any Error> {
        return Future<[GameResponse], Error> { completion in
            if let url = URL(string: Endpoints.Gets.listOfGames.url) {
                AF.request(url)
                    .validate()
                    .responseDecodable(of: GamesResponse.self) { response in
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
    
    func getListOfGamesTopPicks() -> AnyPublisher<[GameResponse], any Error> {
        return Future<[GameResponse], Error> { completion in
            if let url = URL(string: Endpoints.Gets.listOfGamesTopPicks.url) {
                AF.request(url)
                    .validate()
                    .responseDecodable(of: GamesResponse.self) { response in
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
    
    func searchGame(by name: String) -> AnyPublisher<[GameResponse], any Error> {
        return Future<[GameResponse], Error> { completion in
            if let url = URL(string: Endpoints.Gets.searchGames.url + name) {
                AF.request(url)
                    .validate()
                    .responseDecodable(of: GamesResponse.self) { response in
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
