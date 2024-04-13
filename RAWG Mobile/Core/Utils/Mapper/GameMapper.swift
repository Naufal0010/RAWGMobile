//
//  GameMapper.swift
//  RAWG Mobile
//
//  Created by Naufal Abiyyu on 15/03/24.
//

import Foundation
import RealmSwift

final class Mapper {
    
    // MARK: - Top Picks
    static func mapTopPicksResponseToEntities(
        input response: [TopPickResponse]
    ) -> [TopPicksEntity] {
        return response.map { result in
            let genres = mapTopPicksGenreResponsesToEntities(input: result.genres)
            
            let shortScreenshots = mapTopPicksShortScreenshotResponsesToEntities(input: result.shortScreenshots)
            
            let newGame = TopPicksEntity()
            newGame.id = result.id
            newGame.name = result.name
            newGame.released = result.released ?? ""
            newGame.backgroundImage = result.backgroundImage ?? ""
            newGame.rating = result.rating ?? 0.0
            newGame.genres.append(objectsIn: genres)
            newGame.shortScreenshots.append(objectsIn: shortScreenshots)
            
            return newGame
        }
    }
    
    static func mapTopPicksEntitiesToDomains(
        input gameEntities: [TopPicksEntity]
    ) -> [TopPicksModel] {
        return gameEntities.map { result in
            
            let genres = result.genres.map { genre in
                return TopPicksGenreModel(id: genre.id, name: genre.name)
            }
            
            let shortScreenshots = result.shortScreenshots.map { shortScreenshot in
                return TopPicksShortScreenshotModel(id: shortScreenshot.id, image: shortScreenshot.image)
            }
            
            return TopPicksModel(
                id: result.id,
                name: result.name,
                released: result.released,
                backgroundImage: result.backgroundImage,
                rating: result.rating,
                genres: Array(genres),
                shortScreenshots: Array(shortScreenshots),
                isFavorite: result.isFavorite)
        }
    }
    
    // MARK: - Trending
    static func mapTrendingResponseToEntities(
        input response: [TrendingResponse]
    ) -> [TrendingEntity] {
        return response.map { result in
            
            let genres = mapTrendingGenreResponsesToEntities(input: result.genres)
            
            let shortScreenshots = mapTrendingShortScreenshotResponsesToEntities(input: result.shortScreenshots)
            
            let newGame = TrendingEntity()
            newGame.id = result.id
            newGame.name = result.name
            newGame.released = result.released ?? ""
            newGame.backgroundImage = result.backgroundImage ?? ""
            newGame.rating = result.rating ?? 0.0
            newGame.genres.append(objectsIn: genres)
            newGame.shortScreenshots.append(objectsIn: shortScreenshots)
            
            return newGame
        }
    }
    
    static func mapTrendingEntitiesToDomains(
        input gameEntities: [TrendingEntity]
    ) -> [TrendingModel] {
        return gameEntities.map { result in
            
            let genres = result.genres.map { genre in
                return TrendingGenreModel(id: genre.id, name: genre.name)
            }
            
            let shortScreenshots = result.shortScreenshots.map { shortScreenshot in
                return TrendingShortScreenshotModel(id: shortScreenshot.id, image: shortScreenshot.image)
            }
            
            return TrendingModel(
                id: result.id,
                name: result.name,
                released: result.released,
                backgroundImage: result.backgroundImage,
                rating: result.rating,
                genres: Array(genres),
                shortScreenshots: Array(shortScreenshots),
                isFavorite: result.isFavorite)
        }
    }
    
    static func mapDetailResponsesToEntity(
        by id: Int,
        input detailResponse: DetailResponse
    ) -> TopPicksEntity {
                
        let entity = TopPicksEntity()
        entity.id = detailResponse.id
        entity.descriptionGame = detailResponse.description ?? ""
        
        return entity
    }
    
    static func mapDetailEntityToDomain(
        input entity: TopPicksEntity
    ) -> TopPicksModel {
        return TopPicksModel(id: entity.id, descriptionGame: entity.descriptionGame)
    }
    
    static func mapTopPicksDetailEntityToDomain(
        input entity: TopPicksEntity
    ) -> TopPicksModel {
        return TopPicksModel(id: entity.id, descriptionGame: entity.descriptionGame)
    }
    
    
    // MARK: - Genre Top Picks Mapper
    
    static func mapTopPicksGenreResponsesToEntities(
        input response: [TopPicksGenreResponse]
    ) -> [TopPicksGenreEntity] {
        return response.map { result in
            let newGenre = TopPicksGenreEntity()
            newGenre.id = result.id
            newGenre.name = result.name
            
            return newGenre
        }
    }
    
    static func mapTopPicksGenreResponsesToDomains(
        input entity: [TopPicksGenreEntity]
    ) -> [TopPicksGenreModel] {
        return entity.map { result in
            return TopPicksGenreModel(id: result.id, name: result.name)
        }
    }
    
    // MARK: - Genre Trending Mapper
    
    static func mapTrendingGenreResponsesToEntities(
        input response: [TrendingGenreResponse]
    ) -> [TrendingGenreEntity] {
        return response.map { result in
            let newGenre = TrendingGenreEntity()
            newGenre.id = result.id
            newGenre.name = result.name
            
            return newGenre
        }
    }
    
    static func mapTrendingGenreResponsesToDomains(
        input genreEntities: [TrendingGenreEntity]
    ) -> [TrendingModel] {
        return genreEntities.map { result in
            return TrendingModel(id: result.id, name: result.name)
        }
    }
    

    // MARK: - Short Screenshot Top Picks Mapper
    
    static func mapTopPicksShortScreenshotResponsesToEntities(
        input response: [TopPicksShortScreenshotResponse]
    ) -> [TopPicksShortScreenshotEntity] {
        return response.map { result in
            let newSS = TopPicksShortScreenshotEntity()
            newSS.id = result.id
            newSS.image = result.image
            
            return newSS
        }
    }
    
    static func mapTopPicksShortScreenshotResponsesToDomains(
        input entity: [TopPicksShortScreenshotEntity]
    ) -> [TopPicksShortScreenshotModel] {
        return entity.map { result in
            return TopPicksShortScreenshotModel(id: result.id, image: result.image)
        }
    }
    
    // MARK: - Short Screenshot Top Picks Mapper
    
    static func mapTrendingShortScreenshotResponsesToDomains(
        input entity: [TrendingShortScreenshotEntity]
    ) -> [TrendingShortScreenshotModel] {
        return entity.map { result in
            return TrendingShortScreenshotModel(id: result.id, image: result.image)
        }
    }
    
    static func mapTrendingShortScreenshotResponsesToEntities(
        input response: [TrendingShortScreenshotResponse]
    ) -> [TrendingShortScreenshotEntity] {
        return response.map { result in
            let newSS = TrendingShortScreenshotEntity()
            newSS.id = result.id
            newSS.image = result.image
            
            return newSS
        }
    }

}
