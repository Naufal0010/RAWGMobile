//
//  GameModel.swift
//  RAWG Mobile
//
//  Created by Naufal Abiyyu on 13/03/24.
//

import Foundation

struct GameModel: Equatable, Identifiable {
    let id: Int
    var name: String = ""
    var released: String = ""
    var backgroundImage: String = ""
    var descriptionGame: String = ""
    var rating: Double = 0.0
    var genres: [GenreModel] = []
    var shortScreenshots: [ShortScreenshotModel] = []
    var isFavorite: Bool = false
}

struct GenreModel: Equatable, Identifiable {
    let id: Int
    let name: String
}

struct ShortScreenshotModel: Equatable, Identifiable {
    let id: Int
    let image: String
}
