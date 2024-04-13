//
//  LocaleDataSource.swift
//  RAWG Mobile
//
//  Created by Naufal Abiyyu on 14/03/24.
//

import Foundation
import RealmSwift
import Combine

protocol LocaleDataSourceProtocol: AnyObject {
    
    func getTopPicks() -> AnyPublisher<[TopPicksEntity], Error>
    
    func addGamesTopPicks(from games: [TopPicksEntity]) -> AnyPublisher<Bool, Error>
    
    func getTopPicksDetailOfGame(by id: Int) -> AnyPublisher<TopPicksEntity, Error>
    
    func updateTopPicksGame(by id: Int, data: TopPicksEntity) -> AnyPublisher<Bool, Error>
    
    func getTopPicksGamesBy(_ name: String) -> AnyPublisher<[TopPicksEntity], Error>
    
    func addTopicksGamesBy(_ name: String, from games: [TopPicksEntity]) -> AnyPublisher<Bool, Error>
    
    func getTopPicksFavoriteGames() -> AnyPublisher<[TopPicksEntity], Error>
    
    func updateTopPicksFavoriteGame(by id: Int) -> AnyPublisher<TopPicksEntity, Error>
    
    func getTrending() -> AnyPublisher<[TrendingEntity], Error>
    
    func addGamesTrending(from games: [TrendingEntity]) -> AnyPublisher<Bool, Error>
    
    func getTrendingDetailOfGame(by id: Int) -> AnyPublisher<TrendingEntity, Error>
    
    func updateTrendingGame(by id: Int, data: TrendingEntity) -> AnyPublisher<Bool, Error>
    
    func getTrendingGamesBy(_ name: String) -> AnyPublisher<[TrendingEntity], Error>
    
    func addTrendingGamesBy(_ name: String, from games: [TrendingEntity]) -> AnyPublisher<Bool, Error>
    
    func getTrendingFavoriteGames() -> AnyPublisher<[TrendingEntity], Error>
    
    func updateTrendingFavoriteGame(by id: Int) -> AnyPublisher<TrendingEntity , Error>
}

final class LocaleDataSource: NSObject {
    
    private let realm: Realm?
    
    private init(realm: Realm?) {
        self.realm = realm
    }
    
    static let sharedInstance: (Realm?) -> LocaleDataSource = { database in
        return LocaleDataSource(realm: database)
    }
}

extension LocaleDataSource: LocaleDataSourceProtocol {
    
    func getTopPicks() -> AnyPublisher<[TopPicksEntity], any Error> {
        return Future<[TopPicksEntity], Error> { completion in
            if let realm = self.realm {
                let games: Results<TopPicksEntity> = {
                    realm.objects(TopPicksEntity.self)
                }()
                completion(.success(games.toArray(ofType: TopPicksEntity.self)))
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func addGamesTopPicks(from games: [TopPicksEntity]) -> AnyPublisher<Bool, any Error> {
        return Future<Bool, Error> { completion in
                    if let realm = self.realm {
                        do {
                            try realm.write {
                                for game in games {
                                    realm.add(game, update: .all)
                                }
                                completion(.success(true))
                            }
                        } catch {
                            completion(.failure(DatabaseError.requestFailed))
                        }
                    } else {
                        completion(.failure(DatabaseError.invalidInstance))
                    }
                }.eraseToAnyPublisher()
    }
    
    func getTopPicksDetailOfGame(by id: Int) -> AnyPublisher<TopPicksEntity, any Error> {
        return Future<TopPicksEntity, Error> { completion in
                    if let realm = self.realm {
                        let data: Results<TopPicksEntity> = {
                            realm.objects(TopPicksEntity.self)
                                .filter("id == \(id)")
                        }()
                        
                        guard let datum = data.first else {
                            completion(.failure(DatabaseError.requestFailed))
                            return
                        }
                        
                        completion(.success(datum))
                    } else {
                        completion(.failure(DatabaseError.invalidInstance))
                    }
                }.eraseToAnyPublisher()
    }
    
    func updateTopPicksGame(by id: Int, data: TopPicksEntity) -> AnyPublisher<Bool, any Error> {
        return Future<Bool, Error> { completion in
            if let realm = self.realm, let entity = {
                realm.objects(TopPicksEntity.self).filter("id == \(id)")
            }().first {
                do {
                    try realm.write {
                        entity.setValue(data.descriptionGame, forKey: "descriptionGame")
                        entity.setValue(data.isFavorite, forKey: "isFavorite")
                    }
                    completion(.success(true))
                } catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func getTopPicksGamesBy(_ name: String) -> AnyPublisher<[TopPicksEntity], any Error> {
        return Future<[TopPicksEntity], Error> { completion in
            if let realm = self.realm {
                let data: Results<TopPicksEntity> = {
                    realm.objects(TopPicksEntity.self)
                        .filter("name contains[c] %@", name)
                        .sorted(byKeyPath: "name")
                }()
                completion(.success(data.toArray(ofType: TopPicksEntity.self)))
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func addTopicksGamesBy(_ name: String, from games: [TopPicksEntity]) -> AnyPublisher<Bool, any Error> {
        return Future<Bool, Error> { completion in
            if let realm = self.realm {
                do {
                    try realm.write {
                        for game in games {
                            if let entity = realm.object(ofType: TopPicksEntity.self, forPrimaryKey: game.id) {
                                if entity.name == game.name {
                                    game.isFavorite = entity.isFavorite
                                    realm.add(game, update: .all)
                                } else {
                                    realm.add(game)
                                }
                            } else {
                                realm.add(game)
                            }
                        }
                    }
                    completion(.success(true))
                } catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func getTopPicksFavoriteGames() -> AnyPublisher<[TopPicksEntity], any Error> {
        return Future<[TopPicksEntity], Error> { completion in
            if let realm = self.realm {
                let entities = {
                    realm.objects(TopPicksEntity.self)
                        .filter("isFavorite = \(true)")
                        .sorted(byKeyPath: "name")
                }()
                completion(.success(entities.toArray(ofType: TopPicksEntity.self)))
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func updateTopPicksFavoriteGame(by id: Int) -> AnyPublisher<TopPicksEntity, any Error> {
        return Future<TopPicksEntity, Error> { completion in
            if let realm = self.realm, let entity = {
                realm.objects(TopPicksEntity.self).filter("id == \(id)")
            }().first {
                do {
                    try realm.write {
                        entity.setValue(!entity.isFavorite, forKey: "isFavorite")
                    }
                    completion(.success(entity))
                } catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func getTrending() -> AnyPublisher<[TrendingEntity], any Error> {
        return Future<[TrendingEntity], Error> { completion in
            if let realm = self.realm {
                let games: Results<TrendingEntity> = {
                    realm.objects(TrendingEntity.self)
                }()
                completion(.success(games.toArray(ofType: TrendingEntity.self)))
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func addGamesTrending(from games: [TrendingEntity]) -> AnyPublisher<Bool, any Error> {
        return Future<Bool, Error> { completion in
                    if let realm = self.realm {
                        do {
                            try realm.write {
                                for game in games {
                                    realm.add(game, update: .all)
                                }
                                completion(.success(true))
                            }
                        } catch {
                            completion(.failure(DatabaseError.requestFailed))
                        }
                    } else {
                        completion(.failure(DatabaseError.invalidInstance))
                    }
                }.eraseToAnyPublisher()
    }
    
    func getTrendingDetailOfGame(by id: Int) -> AnyPublisher<TrendingEntity, any Error> {
        return Future<TrendingEntity, Error> { completion in
                    if let realm = self.realm {
                        let data: Results<TrendingEntity> = {
                            realm.objects(TrendingEntity.self)
                                .filter("id == \(id)")
                        }()
                        
                        guard let datum = data.first else {
                            completion(.failure(DatabaseError.requestFailed))
                            return
                        }
                        
                        completion(.success(datum))
                    } else {
                        completion(.failure(DatabaseError.invalidInstance))
                    }
                }.eraseToAnyPublisher()
    }
    
    func updateTrendingGame(by id: Int, data: TrendingEntity) -> AnyPublisher<Bool, any Error> {
        return Future<Bool, Error> { completion in
            if let realm = self.realm, let entity = {
                realm.objects(TrendingEntity.self).filter("id == \(id)")
            }().first {
                do {
                    try realm.write {
                        entity.setValue(data.descriptionGame, forKey: "descriptionGame")
                        entity.setValue(data.isFavorite, forKey: "isFavorite")
                    }
                    completion(.success(true))
                } catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func getTrendingGamesBy(_ name: String) -> AnyPublisher<[TrendingEntity], any Error> {
        return Future<[TrendingEntity], Error> { completion in
            if let realm = self.realm {
                let data: Results<TrendingEntity> = {
                    realm.objects(TrendingEntity.self)
                        .filter("name contains[c] %@", name)
                        .sorted(byKeyPath: "name")
                }()
                completion(.success(data.toArray(ofType: TrendingEntity.self)))
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func addTrendingGamesBy(_ name: String, from games: [TrendingEntity]) -> AnyPublisher<Bool, any Error> {
        return Future<Bool, Error> { completion in
            if let realm = self.realm {
                do {
                    try realm.write {
                        for game in games {
                            if let entity = realm.object(ofType: TrendingEntity.self, forPrimaryKey: game.id) {
                                if entity.name == game.name {
                                    game.isFavorite = entity.isFavorite
                                    realm.add(game, update: .all)
                                } else {
                                    realm.add(game)
                                }
                            } else {
                                realm.add(game)
                            }
                        }
                    }
                    completion(.success(true))
                } catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func getTrendingFavoriteGames() -> AnyPublisher<[TrendingEntity], any Error> {
        return Future<[TrendingEntity], Error> { completion in
            if let realm = self.realm {
                let entities = {
                    realm.objects(TrendingEntity.self)
                        .filter("isFavorite = \(true)")
                        .sorted(byKeyPath: "name")
                }()
                completion(.success(entities.toArray(ofType: TrendingEntity.self)))
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func updateTrendingFavoriteGame(by id: Int) -> AnyPublisher<TrendingEntity, any Error> {
        return Future<TrendingEntity, Error> { completion in
            if let realm = self.realm, let entity = {
                realm.objects(TrendingEntity.self).filter("id == \(id)")
            }().first {
                do {
                    try realm.write {
                        entity.setValue(!entity.isFavorite, forKey: "isFavorite")
                    }
                    completion(.success(entity))
                } catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    
}

extension Results {
    
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        
        for index in 0 ..< count {
            if let result = self[index] as? T {
                array.append(result)
            }
        }
        return array
    }
}
