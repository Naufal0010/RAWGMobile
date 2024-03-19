//
//  CustomError.swift
//  RAWG Mobile
//
//  Created by Naufal Abiyyu on 13/03/24.
//

import Foundation

enum URLError: LocalizedError {
    
    case invalidResponse
    case addressUnreachable(URL)
    
    var errorDescription: String? {
        switch self {
        case .invalidResponse: return "The server responded with garbage."
        case .addressUnreachable(let url): return "\(url.absoluteString) is unreachable."
        }
    }
}

enum DatabaseError: LocalizedError {
    
    case invalidInstance
    case requestFailed
    
    var errorDescription: String? {
        switch self {
        case .invalidInstance: return "Database cannot instance."
        case .requestFailed: return "Your request failed."
        }
    }
}
