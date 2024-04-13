//
//  Repository.swift
//  RAWG Mobile
//
//  Created by Naufal Abiyyu on 19/03/24.
//

import Foundation
import Combine

protocol RepositoryProtocol {
    
    func getTopPicksGame() -> AnyPublisher<[TopPicksModel], Error>
    
    func getTrendingGame() -> AnyPublisher<[TrendingModel], Error>
    
    func getDetailGame(by id: Int) -> AnyPublisher<TopPicksModel, Error>
    
}

final class Repository: NSObject {
    
    typealias Instance = (LocaleDataSource, RemoteDataSource) -> Repository
    
    fileprivate let remote: RemoteDataSource
    fileprivate let locale: LocaleDataSource
    
    private init(remote: RemoteDataSource, locale: LocaleDataSource) {
        self.remote = remote
        self.locale = locale
    }
    
    static let sharedInstance: Instance = { localeRepo, remoteRepo in
            return Repository(remote: remoteRepo, locale: localeRepo)
    }
}

extension Repository: RepositoryProtocol {
    
    func getTopPicksGame() -> AnyPublisher<[TopPicksModel], any Error> {
        return self.locale.getTopPicks()
            .flatMap { result -> AnyPublisher<[TopPicksModel], Error> in
                if result.isEmpty {
                    return self.remote.getTopPicksGame()
                        .map { Mapper.mapTopPicksResponseToEntities(input: $0) }
                        .flatMap { self.locale.addGamesTopPicks(from: $0) }
                        .filter { $0 }
                        .flatMap { _ in self.locale.getTopPicks()
                                .map { Mapper.mapTopPicksEntitiesToDomains(input: $0) }
                        }
                        .eraseToAnyPublisher()
                } else {
                    return self.locale.getTopPicks()
                        .map { Mapper.mapTopPicksEntitiesToDomains(input: $0) }
                        .eraseToAnyPublisher()
                }
            }.eraseToAnyPublisher()
    }
    
    func getTrendingGame() -> AnyPublisher<[TrendingModel], any Error> {
        return self.locale.getTrending()
            .flatMap { result -> AnyPublisher<[TrendingModel], Error> in
                if result.isEmpty {
                    return self.remote.getTrendingGame()
                        .map { Mapper.mapTrendingResponseToEntities(input: $0) }
                        .flatMap { self.locale.addGamesTrending(from: $0) }
                        .filter { $0 }
                        .flatMap { _ in self.locale.getTrending()
                                .map { Mapper.mapTrendingEntitiesToDomains(input: $0) }
                        }
                        .eraseToAnyPublisher()
                } else {
                    return self.locale.getTrending()
                        .map { Mapper.mapTrendingEntitiesToDomains(input: $0) }
                        .eraseToAnyPublisher()
                }
            }.eraseToAnyPublisher()
    }
    
    func getDetailGame(by id: Int) -> AnyPublisher<TopPicksModel, any Error> {
        return self.remote.getDetailGame(by: id)
            .flatMap { result -> AnyPublisher<TopPicksModel, Error> in
                if result.description == "" {
                    return self.remote.getDetailGame(by: id)
                        .map { Mapper.mapDetailResponsesToEntity(by: id, input: $0) }
                        .catch { _ in self.locale.getTopPicksDetailOfGame(by: id) }
                        .flatMap { self.locale.updateTopPicksGame(by: id, data: $0) }
                        .filter { $0 }
                        .flatMap { _ in self.locale.getTopPicksDetailOfGame(by: id)
                                .map { Mapper.mapDetailEntityToDomain(input: $0) }
                        }
                        .eraseToAnyPublisher()
                } else {
                    return self.locale.getTopPicksDetailOfGame(by: id)
                        .map { Mapper.mapDetailEntityToDomain(input: $0) }
                        .eraseToAnyPublisher()
                }
            }.eraseToAnyPublisher()
    }
}
