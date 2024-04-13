//
//  TrendingModel.swift
//  RAWG Mobile
//
//  Created by Naufal Abiyyu on 13/03/24.
//

import Foundation

struct TrendingModel: Equatable, Identifiable {
    let id: Int
    var name: String = ""
    var released: String = ""
    var backgroundImage: String = ""
    var descriptionGame: String = ""
    var rating: Double = 0.0
    var genres: [TrendingGenreModel] = []
    var shortScreenshots: [TrendingShortScreenshotModel] = []
    var isFavorite: Bool = false
}

struct TrendingGenreModel: Equatable, Identifiable {
    let id: Int
    let name: String
}

struct TrendingShortScreenshotModel: Equatable, Identifiable {
    let id: Int
    let image: String
}
