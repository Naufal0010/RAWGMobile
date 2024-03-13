//
//  SplashView.swift
//  RAWG Mobile
//
//  Created by Naufal Abiyyu on 05/03/24.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        Text("RAWG")
            .fontWeight(.black)
            .foregroundStyle(.text)
            .font(.system(size: 56))
            .tracking(10.0)
            .shadow(color: .text.opacity(0.2), radius: 5, x: 4, y: 4)
        
    }
}

#Preview {
    SplashView()
}
