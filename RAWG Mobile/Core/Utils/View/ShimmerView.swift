//
//  ShimmerView.swift
//  RAWG Mobile
//
//  Created by Naufal Abiyyu on 27/03/24.
//

import SwiftUI
import Shimmer

enum ShimmerState {
    case horizontal
    case vertical
}

struct ShimmerView: View {
    @State var selectedShimmer: ShimmerState
    
    var body: some View {
        ZStack {
            switch selectedShimmer {
            case .horizontal:
                shimmerHorizontal
            case .vertical:
                shimmerVertical
            }
        }
    }
}

extension ShimmerView {
    
    var shimmerHorizontal: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(.gray.opacity(0.3))
                .frame(maxWidth: .infinity)
                .frame(height: 120)
                .redacted(reason: .placeholder)
                .shimmering(gradient: Gradient(colors: [
                    .white.opacity(0.5),
                    .white.opacity(0.3),
                    .white.opacity(0.5)
                ]))
                .shadow(color: Color.black.opacity(0.3), radius: 10, x: 4, y: 4)
        }
    }
    
    var shimmerVertical: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(.gray.opacity(0.3))
                .frame(width: 200, height: 280)
                .redacted(reason: .placeholder)
                .shimmering(gradient: Gradient(colors: [
                    .white.opacity(0.5),
                    .white.opacity(0.3),
                    .white.opacity(0.5)
                ]))
                .shadow(color: Color.black.opacity(0.3), radius: 10, x: 4, y: 4)
        }
    }
}

#Preview {
    ShimmerView(selectedShimmer: .vertical)
}
