//
//  TrendingResponse.swift
//  RAWG Mobile
//
//  Created by Naufal Abiyyu on 02/04/24.
//

import Foundation

// MARK: - result
struct TrendingsResponse: Decodable {
    let results: [TrendingResponse]
}

// MARK: - main attribute
struct TrendingResponse: Decodable {
    let id: Int
    let name: String
    let released: String?
    let backgroundImage: String?
    let rating: Double?
    let metacritic: Int?
    let genres: [TrendingGenreResponse]
    let shortScreenshots: [TrendingShortScreenshotResponse]

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
struct TrendingGenreResponse: Decodable {
    let id: Int
    let name: String
}

// MARK: - ShortScreenshot
struct TrendingShortScreenshotResponse: Decodable {
    let id: Int
    let image: String
}
