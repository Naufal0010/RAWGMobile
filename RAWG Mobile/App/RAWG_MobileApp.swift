//
//  RAWG_MobileApp.swift
//  RAWG Mobile
//
//  Created by Naufal Abiyyu on 01/03/24.
//

import SwiftUI

@main
struct RAWG_MobileApp: App {
    let dashboardPresenter = DashboardPresenter(
        dashboardUseCase: Injection.init().provideDashboard())
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(dashboardPresenter)
        }
    }
}
