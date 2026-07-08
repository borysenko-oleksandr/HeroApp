//
//  API.swift
//  HeroApp
//
//  Created by User on 02.07.2026.
//

import Foundation

public enum HTTPMethod: String {
    case GET = "Get"
    case POST = "Post"
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
