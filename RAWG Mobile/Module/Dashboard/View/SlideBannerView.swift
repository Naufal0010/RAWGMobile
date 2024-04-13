//
//  SlideBannerView.swift
//  RAWG Mobile
//
//  Created by Naufal Abiyyu on 21/03/24.
//

import SwiftUI
import CachedAsyncImage

struct SlideBannerView: View {
    var data: TrendingModel
    
    var body: some View {
        VStack(alignment: .leading) {
            CachedAsyncImage(url: URL(string: data.backgroundImage)) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 280)
                    .clipShape(.rect(cornerRadius: 10))
                    .shadow(color: .text.opacity(0.2), radius: 10, x: 4, y: 4)

            } placeholder: {
                ProgressView("")
                    .progressViewStyle(CircularProgressViewStyle())
                    .tint(.gray)
                    .frame(width: 200, height: 280)
            }
                        
            Text(data.name)
                .font(.system(size: 12))
                .fontWeight(.regular)
                .padding(.top, 4)
                .frame(width: 200, alignment: .topLeading)
            
            Spacer()
            
        }
    }
}

#Preview {
    SlideBannerView(data: TrendingModel(
        id: 303576,
        name: "Vampire: The Masquerade - Bloodlines 2",
        released: "2024-11-30",
        backgroundImage: "https://media.rawg.io/media/games/fb5/fb5e0fdb1f6bb0e8b5da5d08bb83a5fc.jpg",
        descriptionGame: "",
        rating: 3.97,
        genres: [TrendingGenreModel(id: 4, name: "Action"), TrendingGenreModel(id: 5, name: "RPG")],
        shortScreenshots: [TrendingShortScreenshotModel(id: 1886816, image: "https://media.rawg.io/media/screenshots/eb7/eb7d75e25be2c76d6e1bd454f2071aad.jpg")],
        isFavorite: false)
    )
}
