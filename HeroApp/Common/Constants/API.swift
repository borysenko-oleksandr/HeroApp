//
//  API.swift
//  HeroApp
//
//  Created by User on 02.07.2026.
//

import Foundation

public enum HTTPMethod: String {
    case GET
    case POST
}

public enum NetworkHandlerError: Error, Sendable {
   case InvalidURL
   case JSONDecodingError
   case RequestError(String)
   case UnknownError
}

public enum URI: String {
    case Character  = "/character"
}

struct URLString {
    private let base = "https://rickandmortyapi.com/api"
    
    func getUrlString(for uri: URI) -> String {
        return "\(base)\(uri.rawValue)"
    }
    
    func getUrlString(for uri: URI, with params: String) -> String {
        return "\(base)\(uri.rawValue)/\(params)"
    }
}
