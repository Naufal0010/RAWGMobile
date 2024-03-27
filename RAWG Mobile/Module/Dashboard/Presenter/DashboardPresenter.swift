//
//  DashboardPresenter.swift
//  RAWG Mobile
//
//  Created by Naufal Abiyyu on 20/03/24.
//

import SwiftUI
import Combine

class DashboardPresenter: ObservableObject {
    
    private let dashboardUseCase: DashboardUseCase
    private var cancellables: Set<AnyCancellable> = []
    
    @Published var games: [GameModel] = []
    @Published var errorMessage: String = ""
    @Published var isLoading: Bool = false
    
    init(dashboardUseCase: DashboardUseCase) {
        self.dashboardUseCase = dashboardUseCase
    }
    
    func getListOfGames() {
        isLoading = true
        dashboardUseCase.getListOfGames()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    self.isLoading = false
                case .failure:
                    self.errorMessage = String(describing: completion)
                }
            }, receiveValue: { data in
                self.games = data
            })
            .store(in: &cancellables)
    }
    
    func getTopPicksGames() {
        isLoading = true
        dashboardUseCase.getListOfGamesTopPicks()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    self.isLoading = false
                case .failure:
                    self.errorMessage = String(describing: completion)
                }
            }, receiveValue: { data in
                self.games = data
            })
            .store(in: &cancellables)
    }
}
