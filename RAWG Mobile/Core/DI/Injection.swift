//
//  Injection.swift
//  RAWG Mobile
//
//  Created by Naufal Abiyyu on 19/03/24.
//

import Foundation
import RealmSwift

final class Injection: NSObject {
    
    private func provideRepository() -> RepositoryProtocol {
        let realm = try? Realm()
        
        let locale: LocaleDataSource = LocaleDataSource.sharedInstance(realm)
        let remote: RemoteDataSource = RemoteDataSource.sharedInstance
        
        return Repository.sharedInstance(locale, remote)
    }
    
    func provideDashboard() -> DashboardUseCase {
        let repository = provideRepository()
        
        return DashboardInteractor(repository: repository)
    }
    
    func provideDetail(data: GameModel) -> DetailUseCase {
        let repository = provideRepository()
        
        return DetailInteractor(repository: repository, model: data)
    }
}
