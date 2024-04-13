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
    
    @Published var trending: [TrendingModel] = []
    @Published var topPicks: [TopPicksModel] = []
    @Published var errorMessage: String = ""
    @Published var isLoading: Bool = false
    
    init(dashboardUseCase: DashboardUseCase) {
        self.dashboardUseCase = dashboardUseCase
    }
    
    func getTrending() {
        isLoading = true
        dashboardUseCase.getTrending()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    self.isLoading = false
                case .failure:
                    self.errorMessage = String(describing: completion)
                }
            }, receiveValue: { data in
                self.trending = data
//                debugPrint(data[0])
            })
            .store(in: &cancellables)
    }
    
    func getTopPicksGames() {
        isLoading = true
        dashboardUseCase.getTopPicks()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    self.isLoading = false
                case .failure:
                    self.errorMessage = String(describing: completion)
                }
            }, receiveValue: { data in
                self.topPicks = data
//                debugPrint(data[0])
            })
            .store(in: &cancellables)
    }
}
