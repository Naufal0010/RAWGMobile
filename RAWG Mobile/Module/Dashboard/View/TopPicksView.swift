//
//  TopPicksView.swift
//  RAWG Mobile
//
//  Created by Naufal Abiyyu on 21/03/24.
//

import SwiftUI
import CachedAsyncImage

struct TopPicksView: View {
    var data: TopPicksModel
    
    var body: some View {
        VStack(alignment: .leading) {
            rowView
            
            Divider()
        }
    }
}

extension TopPicksView {
    
    func formatDate(_ dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let date = dateFormatter.date(from: dateString) else {
            return nil
        }
        
        dateFormatter.dateFormat = "EEEE, dd-MM-yyyy"
        return dateFormatter.string(from: date)
    }
    
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
                    .frame(width: 80, height: 100)
            }
            
            VStack(alignment: .leading) {
                Text(data.name)
                    .font(.system(size: 14))
                    .fontWeight(.semibold)
                    .padding(.bottom, 2)
                
                Text(formatDate(data.released) ?? "-")
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
    TopPicksView(data: TopPicksModel(
        id: 303576,
        name: "Vampire: The Masquerade - Bloodlines 2",
        released: "2024-11-30",
        backgroundImage: "https://media.rawg.io/media/games/fb5/fb5e0fdb1f6bb0e8b5da5d08bb83a5fc.jpg",
        descriptionGame: "",
        rating: 3.97,
        genres: [TopPicksGenreModel(id: 4, name: "Action"), TopPicksGenreModel(id: 5, name: "RPG")],
        shortScreenshots: [TopPicksShortScreenshotModel(id: 1886816, image: "https://media.rawg.io/media/screenshots/eb7/eb7d75e25be2c76d6e1bd454f2071aad.jpg")],
        isFavorite: false))
}
