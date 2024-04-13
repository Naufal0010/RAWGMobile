//
//  TopPicksEntity.swift
//  RAWG Mobile
//
//  Created by Naufal Abiyyu on 03/04/24.
//

import Foundation
import RealmSwift

class TopPicksEntity: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var released: String = ""
    @objc dynamic var backgroundImage: String = ""
    @objc dynamic var descriptionGame: String = ""
    @objc dynamic var rating: Double = 0.0
    var genres = List<TopPicksGenreEntity>()
    var shortScreenshots = List<TopPicksShortScreenshotEntity>()
    @objc dynamic var isFavorite: Bool = false
    
    override class func primaryKey() -> String? {
        return "id"
    }
}

class TopPicksGenreEntity: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
}

class TopPicksShortScreenshotEntity: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var image: String = ""
}
