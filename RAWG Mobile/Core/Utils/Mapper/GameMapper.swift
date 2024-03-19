//
//  GameMapper.swift
//  RAWG Mobile
//
//  Created by Naufal Abiyyu on 15/03/24.
//

import Foundation
import RealmSwift

final class Mapper {
    
    static func mapGameResponseToEntities(
        input gameResponses: [GameResponse]
    ) -> [Entity] {
        return gameResponses.map { result in
            
            let genres = mapGenreResponsesToEntities(input: result.genres)
            
            let shortScreenshots = mapShortScreenshotResponsesToEntities(input: result.shortScreenshots)
            
            let newGame = Entity()
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
    
    static func mapGameEntitiesToDomains(
        input gameEntities: [Entity]
    ) -> [GameModel] {
        return gameEntities.map { result in
            
            let genres = result.genres.map { genre in
                return GenreModel(id: genre.id, name: genre.name)
            }
            
            let shortScreenshots = result.shortScreenshots.map { shortScreenshot in
                return ShortScreenshotModel(id: shortScreenshot.id, image: shortScreenshot.image)
            }
            
            return GameModel(
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
    ) -> Entity {
                
        let entity = Entity()
        entity.id = detailResponse.id
        entity.descriptionGame = detailResponse.description ?? ""
        
        return entity
    }
    
    static func mapDetailEntityToDomain(
        input entity: Entity
    ) -> GameModel {
        return GameModel(id: entity.id, descriptionGame: entity.descriptionGame)
    }
    
    static func mapGenreResponsesToEntities(
        input genreResponses: [GenreResponse]
    ) -> [GenreEntity] {
        return genreResponses.map { result in
            let newGenre = GenreEntity()
            newGenre.id = result.id
            newGenre.name = result.name
            
            return newGenre
        }
    }
    
    static func mapGenreResponsesToDomains(
        input genreEntities: [GenreEntity]
    ) -> [GenreModel] {
        return genreEntities.map { result in
            return GenreModel(id: result.id, name: result.name)
        }
    }

    
    static func mapShortScreenshotResponsesToEntities(
        input shortScreenshots: [ShortScreenshotResponse]
    ) -> [ShortScreenshotEntity] {
        return shortScreenshots.map { result in
            let newSS = ShortScreenshotEntity()
            newSS.id = result.id
            newSS.image = result.image
            
            return newSS
        }
    }
    
    static func mapShortScreenshotResponsesToDomains(
        input shortScreenshotEntities: [ShortScreenshotEntity]
    ) -> [ShortScreenshotModel] {
        return shortScreenshotEntities.map { result in
            return ShortScreenshotModel(id: result.id, image: result.image)
        }
    }
    
    
}
