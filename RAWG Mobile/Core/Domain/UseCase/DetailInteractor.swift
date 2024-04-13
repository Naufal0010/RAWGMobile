//
//  DetailInteractor.swift
//  RAWG Mobile
//
//  Created by Naufal Abiyyu on 19/03/24.
//

import Foundation
import Combine

protocol DetailUseCase {
    
    func getDetailGame() -> TopPicksModel
    
    func getDetailGame() -> AnyPublisher<TopPicksModel, Error>
    
}

class DetailInteractor: DetailUseCase {
    
    private let repository: RepositoryProtocol
    private let model: TopPicksModel
    
    required init(repository: RepositoryProtocol, model: TopPicksModel) {
        self.repository = repository
        self.model = model
    }
    
    func getDetailGame() -> TopPicksModel {
        return model
    }
    
    func getDetailGame() -> AnyPublisher<TopPicksModel, any Error> {
        return repository.getDetailGame(by: model.id)
    }
}
