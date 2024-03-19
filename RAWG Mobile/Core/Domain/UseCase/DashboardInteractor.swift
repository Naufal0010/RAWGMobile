//
//  HomeInteractor.swift
//  RAWG Mobile
//
//  Created by Naufal Abiyyu on 19/03/24.
//

import Foundation
import Combine

protocol DashboardUseCase {
    
    func getListOfGames() -> AnyPublisher<[GameModel], Error>
    
    func getListOfGamesTopPicks() -> AnyPublisher<[GameModel], Error>
    
}

class DashboardInteractor: DashboardUseCase {
        
    private let repository: RepositoryProtocol
    
    required init(repository: RepositoryProtocol) {
        self.repository = repository
    }
    
    func getListOfGames() -> AnyPublisher<[GameModel], any Error> {
        return repository.getListOfGames()
    }
    
    func getListOfGamesTopPicks() -> AnyPublisher<[GameModel], any Error> {
        return repository.getListOfGamesTopPicks()
    }
}
