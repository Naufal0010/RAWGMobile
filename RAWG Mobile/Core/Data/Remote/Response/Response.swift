//
//  Response.swift
//  RAWG Mobile
//
//  Created by Naufal Abiyyu on 13/03/24.
//

import Foundation

// MARK: - Rawg
struct GamesResponse: Decodable {
    let results: [GameResponse]
}

// MARK: - RAWG
struct GameResponse: Decodable {
    let id: Int
    let name: String
    let released: String?
    let backgroundImage: String?
    let rating: Double?
    let metacritic: Int?
    let genres: [GenreResponse]
    let shortScreenshots: [ShortScreenshotResponse]

    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case backgroundImage = "background_image"
        case rating
        case released
        case metacritic
        case genres
        case shortScreenshots = "short_screenshots"
    }
}

// MARK: - Genre
struct GenreResponse: Decodable {
    let id: Int
    let name: String
}

// MARK: - ShortScreenshot
struct ShortScreenshotResponse: Decodable {
    let id: Int
    let image: String
}
