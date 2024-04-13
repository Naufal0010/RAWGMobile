//
//  HomeInteractor.swift
//  RAWG Mobile
//
//  Created by Naufal Abiyyu on 19/03/24.
//

import Foundation
import Combine

protocol DashboardUseCase {
    
    func getTopPicks() -> AnyPublisher<[TopPicksModel], Error>
    
    func getTrending() -> AnyPublisher<[TrendingModel], Error>
    
}

class DashboardInteractor: DashboardUseCase {
        
    private let repository: RepositoryProtocol
    
    required init(repository: RepositoryProtocol) {
        self.repository = repository
    }
    
    func getTopPicks() -> AnyPublisher<[TopPicksModel], any Error> {
        return repository.getTopPicksGame()
    }
    
    func getTrending() -> AnyPublisher<[TrendingModel], any Error> {
        return repository.getTrendingGame()
    }
}
