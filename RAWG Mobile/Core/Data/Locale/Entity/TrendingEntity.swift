//
//  TrendingEntity.swift
//  RAWG Mobile
//
//  Created by Naufal Abiyyu on 13/03/24.
//

import Foundation
import RealmSwift

class TrendingEntity: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var released: String = ""
    @objc dynamic var backgroundImage: String = ""
    @objc dynamic var descriptionGame: String = ""
    @objc dynamic var rating: Double = 0.0
    var genres = List<TrendingGenreEntity>()
    var shortScreenshots = List<TrendingShortScreenshotEntity>()
    @objc dynamic var isFavorite: Bool = false
    
    override class func primaryKey() -> String? {
        return "id"
    }
}

class TrendingGenreEntity: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
}

class TrendingShortScreenshotEntity: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var image: String = ""
}

