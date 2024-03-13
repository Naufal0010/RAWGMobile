//
//  ContentView.swift
//  RAWG Mobile
//
//  Created by Naufal Abiyyu on 01/03/24.
//

import SwiftUI

struct ContentView: View {
    @State private var showSplash = true
    
    var body: some View {
        ZStack {
            if showSplash {
                SplashView()
                    .transition(.opacity)
                    .animation(.easeOut(duration: 1.5), value: showSplash)
            } else {
                DashboardView()
            }
        }
        .onAppear {
            DispatchQueue.main
                .asyncAfter(deadline: .now() + 2) {
                    withAnimation {
                        self.showSplash = false
                    }
                }
        }
    }
}

#Preview {
    ContentView()
}
