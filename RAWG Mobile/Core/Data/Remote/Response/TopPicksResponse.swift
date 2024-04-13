//
//  Response.swift
//  RAWG Mobile
//
//  Created by Naufal Abiyyu on 13/03/24.
//

import Foundation

// MARK: - result
struct TopPicksResponse: Decodable {
    let results: [TopPickResponse]
}

// MARK: - main attribute
struct TopPickResponse: Decodable {
    let id: Int
    let name: String
    let released: String?
    let backgroundImage: String?
    let rating: Double?
    let metacritic: Int?
    let genres: [TopPicksGenreResponse]
    let shortScreenshots: [TopPicksShortScreenshotResponse]

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
struct TopPicksGenreResponse: Decodable {
    let id: Int
    let name: String
}

// MARK: - ShortScreenshot
struct TopPicksShortScreenshotResponse: Decodable {
    let id: Int
    let image: String
}
