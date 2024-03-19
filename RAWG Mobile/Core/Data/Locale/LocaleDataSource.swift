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
    
    func getListOfGames() -> AnyPublisher<[Entity], Error>
    
    func getListOfGamesTopPicks() -> AnyPublisher<[Entity], Error>
    
    func addGames(from games: [Entity]) -> AnyPublisher<Bool, Error>
    
    func getDetailOfGame(by id: Int) -> AnyPublisher<Entity, Error>
    
    func updateGame(by id: Int, data: Entity) -> AnyPublisher<Bool, Error>
    
    func getGamesBy(_ name: String) -> AnyPublisher<[Entity], Error>
    
    func addGamesBy(_ name: String, from games: [Entity]) -> AnyPublisher<Bool, Error>
    
    func getFavoriteGames() -> AnyPublisher<[Entity], Error>
    
    func updateFavoriteGame(by id: Int) -> AnyPublisher<Entity, Error>
    
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
    
    func getListOfGames() -> AnyPublisher<[Entity], any Error> {
        return Future<[Entity], Error> { completion in
            if let realm = self.realm {
                let games: Results<Entity> = {
                    realm.objects(Entity.self)
                }()
                completion(.success(games.toArray(ofType: Entity.self)))
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func getListOfGamesTopPicks() -> AnyPublisher<[Entity], any Error> {
        return Future<[Entity], Error> { completion in
            if let realm = self.realm {
                let topPicks: Results<Entity> = {
                    realm.objects(Entity.self)
                }()
                completion(.success(topPicks.toArray(ofType: Entity.self)))
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func addGames(from games: [Entity]) -> AnyPublisher<Bool, any Error> {
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
    
    func getDetailOfGame(by id: Int) -> AnyPublisher<Entity, any Error> {
        return Future<Entity, Error> { completion in
            if let realm = self.realm {
                let data: Results<Entity> = {
                    realm.objects(Entity.self)
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
    
    func updateGame(by id: Int, data: Entity) -> AnyPublisher<Bool, any Error> {
        return Future<Bool, Error> { completion in
            if let realm = self.realm, let entity = {
                realm.objects(Entity.self).filter("id == \(id)")
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
    
    func getGamesBy(_ name: String) -> AnyPublisher<[Entity], any Error> {
        return Future<[Entity], Error> { completion in
            if let realm = self.realm {
                let data: Results<Entity> = {
                    realm.objects(Entity.self)
                        .filter("name contains[c] %@", name)
                        .sorted(byKeyPath: "name")
                }()
                completion(.success(data.toArray(ofType: Entity.self)))
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func addGamesBy(_ name: String, from games: [Entity]) -> AnyPublisher<Bool, any Error> {
        return Future<Bool, Error> { completion in
            if let realm = self.realm {
                do {
                    try realm.write {
                        for game in games {
                            if let entity = realm.object(ofType: Entity.self, forPrimaryKey: game.id) {
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
    
    func getFavoriteGames() -> AnyPublisher<[Entity], any Error> {
        return Future<[Entity], Error> { completion in
            if let realm = self.realm {
                let entities = {
                    realm.objects(Entity.self)
                        .filter("isFavorite = \(true)")
                        .sorted(byKeyPath: "name")
                }()
                completion(.success(entities.toArray(ofType: Entity.self)))
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func updateFavoriteGame(by id: Int) -> AnyPublisher<Entity, any Error> {
        return Future<Entity, Error> { completion in
            if let realm = self.realm, let entity = {
                realm.objects(Entity.self).filter("id == \(id)")
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
