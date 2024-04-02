//
//  APICall.swift
//  RAWG Mobile
//
//  Created by Naufal Abiyyu on 13/03/24.
//

import Foundation

struct API {
    
    static let baseURL = "https://api.rawg.io/api"
    
    static var apiKey: String {
        guard let filePath = Bundle.main.path(forResource: "RAWG-Mobile-Info", ofType: "plist") else {
            fatalError("Couldn't find file 'RAWG-Mobile-Info'.")
        }
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "API_KEY") as? String else {
            fatalError("Couldn't find key 'API_KEY' in 'RAWG-Mobile-Info'.")
        }
        
        return value
    }
}

protocol Endpoint {
    
    var url: String { get }
    
}

enum Endpoints {
    
    enum Gets: Endpoint {
        case listOfGames
        case listOfGamesTopPicks
        case gameDetail(_ id: Int)
        case searchGames
        
        public var url: String {
            switch self {
            case .listOfGames: return "\(API.baseURL)/games?key=\(API.apiKey)"
            case .listOfGamesTopPicks: return "\(API.baseURL)/games/lists/main?key=\(API.apiKey)&ordering=-relevance"
            case .gameDetail(let id): return "\(API.baseURL)/games/\(id)?key=\(API.apiKey)"
            case .searchGames: return "\(API.baseURL)/games?key=\(API.apiKey)&search="
            }
        }
    }
}
