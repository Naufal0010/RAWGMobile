//
//  TopPicksView.swift
//  RAWG Mobile
//
//  Created by Naufal Abiyyu on 21/03/24.
//

import SwiftUI
import CachedAsyncImage

struct TopPicksView: View {
    var data: GameModel
    
    var body: some View {
        VStack {
            rowView
            
            Divider()
                .padding(.horizontal, 16)
        }
    }
}

extension TopPicksView {
    
    var rowView: some View {
        HStack {
            CachedAsyncImage(url: URL(string: data.backgroundImage)) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 100)
                    .clipShape(.rect(cornerRadius: 10))
                    .shadow(color: .text.opacity(0.2), radius: 10, x: 4, y: 4)
                
            } placeholder: {
                ProgressView("")
                    .progressViewStyle(CircularProgressViewStyle())
                    .tint(.gray)
                    .frame(width: 120, height: 120)
            }
            
            VStack(alignment: .leading) {
                Text(data.name)
                    .font(.system(size: 14))
                    .fontWeight(.semibold)
                    .padding(.bottom, 2)
                
                Text(data.released)
                    .font(.system(size: 10))
                
                Spacer()
                
                HStack {
                    let genreNames = data.genres.map { $0.name }.joined(separator: " • ")
                    
                    Text(genreNames)
                        .font(.system(size: 10))
                        .foregroundStyle(.text)
                }
            }
            .frame(height: 100)
        }
    }
}

#Preview {
    TopPicksView(data: GameModel(
        id: 303576,
        name: "Vampire: The Masquerade - Bloodlines 2",
        released: "2024-11-30",
        backgroundImage: "https://media.rawg.io/media/games/fb5/fb5e0fdb1f6bb0e8b5da5d08bb83a5fc.jpg",
        descriptionGame: "",
        rating: 3.97,
        genres: [GenreModel(id: 4, name: "Action"), GenreModel(id: 5, name: "RPG")],
        shortScreenshots: [ShortScreenshotModel(id: 1886816, image: "https://media.rawg.io/media/screenshots/eb7/eb7d75e25be2c76d6e1bd454f2071aad.jpg")],
        isFavorite: false))
}
