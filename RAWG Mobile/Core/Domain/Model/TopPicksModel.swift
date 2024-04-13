//
//  TopPicksModel.swift
//  RAWG Mobile
//
//  Created by Naufal Abiyyu on 02/04/24.
//

import Foundation

struct TopPicksModel: Equatable, Identifiable {
    let id: Int
    var name: String = ""
    var released: String = ""
    var backgroundImage: String = ""
    var descriptionGame: String = ""
    var rating: Double = 0.0
    var genres: [TopPicksGenreModel] = []
    var shortScreenshots: [TopPicksShortScreenshotModel] = []
    var isFavorite: Bool = false
}

struct TopPicksGenreModel: Equatable, Identifiable {
    let id: Int
    let name: String
}

struct TopPicksShortScreenshotModel: Equatable, Identifiable {
    let id: Int
    let image: String
}
