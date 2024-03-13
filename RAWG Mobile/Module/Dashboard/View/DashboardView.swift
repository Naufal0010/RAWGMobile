//
//  DashboardView.swift
//  RAWG Mobile
//
//  Created by Naufal Abiyyu on 13/03/24.
//

import SwiftUI

struct DashboardView: View {
    var body: some View {
        dashboardBody
    }
}

#Preview {
    DashboardView()
}

extension DashboardView {
    
    // MARK: Complete the body view
    var dashboardBody: some View {
        NavigationStack {
            List {
                
            }
        }
        .navigationTitle("New and trending")
    }
}
