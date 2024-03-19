//
//  DetailInteractor.swift
//  RAWG Mobile
//
//  Created by Naufal Abiyyu on 19/03/24.
//

import Foundation
import Combine

protocol DetailUseCase {
    
    func getDetailGame() -> GameModel
    
    func getDetailGame() -> AnyPublisher<GameModel, Error>
    
}

class DetailInteractor: DetailUseCase {
    
    private let repository: RepositoryProtocol
    private let model: GameModel
    
    required init(repository: RepositoryProtocol, model: GameModel) {
        self.repository = repository
        self.model = model
    }
    
    func getDetailGame() -> GameModel {
        return model
    }
    
    func getDetailGame() -> AnyPublisher<GameModel, any Error> {
        return repository.getDetailGame(by: model.id)
    }
}
