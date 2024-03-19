//
//  Repository.swift
//  RAWG Mobile
//
//  Created by Naufal Abiyyu on 19/03/24.
//

import Foundation
import Combine

protocol RepositoryProtocol {
    
    func getListOfGames() -> AnyPublisher<[GameModel], Error>
    
    func getListOfGamesTopPicks() -> AnyPublisher<[GameModel], Error>
    
    func getDetailGame(by id: Int) -> AnyPublisher<GameModel, Error>
    
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
    
    func getListOfGames() -> AnyPublisher<[GameModel], any Error> {
        return self.locale.getListOfGames()
            .flatMap { result -> AnyPublisher<[GameModel], Error> in
                if result.isEmpty {
                    return self.remote.getListOfGames()
                        .map { Mapper.mapGameResponseToEntities(input: $0) }
                        .flatMap { self.locale.addGames(from: $0) }
                        .filter { $0 }
                        .flatMap { _ in self.locale.getListOfGames()
                                .map { Mapper.mapGameEntitiesToDomains(input: $0) }
                        }
                        .eraseToAnyPublisher()
                } else {
                    return self.locale.getListOfGames()
                        .map { Mapper.mapGameEntitiesToDomains(input: $0) }
                        .eraseToAnyPublisher()
                }
            }.eraseToAnyPublisher()
    }
    
    func getListOfGamesTopPicks() -> AnyPublisher<[GameModel], any Error> {
        return self.locale.getListOfGamesTopPicks()
            .flatMap { result -> AnyPublisher<[GameModel], Error> in
                if result.isEmpty {
                    return self.remote.getListOfGamesTopPicks()
                        .map { Mapper.mapGameResponseToEntities(input: $0) }
                        .flatMap { self.locale.addGames(from: $0) }
                        .filter { $0 }
                        .flatMap { _ in self.locale.getListOfGamesTopPicks()
                                .map { Mapper.mapGameEntitiesToDomains(input: $0) }
                        }
                        .eraseToAnyPublisher()
                } else {
                    return self.locale.getListOfGamesTopPicks()
                        .map { Mapper.mapGameEntitiesToDomains(input: $0) }
                        .eraseToAnyPublisher()
                }
            }.eraseToAnyPublisher()
    }
    
    func getDetailGame(by id: Int) -> AnyPublisher<GameModel, any Error> {
        return self.remote.getDetailGame(by: id)
            .flatMap { result -> AnyPublisher<GameModel, Error> in
                if result.description == "" {
                    return self.remote.getDetailGame(by: id)
                        .map { Mapper.mapDetailResponsesToEntity(by: id, input: $0) }
                        .catch { _ in self.locale.getDetailOfGame(by: id) }
                        .flatMap { self.locale.updateGame(by: id, data: $0) }
                        .filter { $0 }
                        .flatMap { _ in self.locale.getDetailOfGame(by: id)
                                .map { Mapper.mapDetailEntityToDomain(input: $0) }
                        }
                        .eraseToAnyPublisher()
                } else {
                    return self.locale.getDetailOfGame(by: id)
                        .map { Mapper.mapDetailEntityToDomain(input: $0) }
                        .eraseToAnyPublisher()
                }
            }.eraseToAnyPublisher()
    }
}
