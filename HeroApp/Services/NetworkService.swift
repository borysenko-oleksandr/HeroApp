//
//  NetworkSerice.swift
//  HeroApp
//
//  Created by User on 02.07.2026.
//

import Foundation


struct ResponseErrorMessage: Codable {
    let error: String
}

public struct NetworkService {
    // TODO: move to config
    var baseURL: String = "https://rickandmortyapi.com/api"
    
    func request(
        urlString: String,
        methods: HTTPMethod,
        body: Data? = nil) async throws -> Data {
            let fullURL = baseURL + urlString
            
            guard let url = URL(string: fullURL) else {
                throw NetworkHandlerError.InvalidURL
            }
            
            var request = URLRequest(url: url)
            
            request.httpMethod = methods.rawValue
            request.httpBody = body
            
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, 200..<299 ~= statusCode else {
                let error: ResponseErrorMessage = try decodeJSONData(data)
                throw NetworkHandlerError.RequestError(error.error)
            }
            
            return data
        }
    
    
    func decodeJSONData<T: Decodable>(_ data: Data) throws -> T {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(T.self, from: data)
            return decodedData
        } catch {
            throw NetworkHandlerError.JSONDecodingError
        }
    }
}
