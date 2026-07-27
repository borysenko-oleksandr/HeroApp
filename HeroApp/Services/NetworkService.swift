//
//  NetworkSerice.swift
//  HeroApp
//
//  Created by User on 02.07.2026.
//

import Foundation

protocol NetworkServiceProtocol {
    func request(
        urlString: URI,
        methods: HTTPMethod,
        body: Data?,
        params: String?,
    ) async throws -> Data
    func decodeJSONData<T: Decodable>(_ data: Data) throws -> T
}

struct ResponseErrorMessage: Codable {
    let error: String
}

public struct NetworkService: NetworkServiceProtocol {
    var urlSession: URLSession = .shared
    var url = URLString()
    
    func request(
        urlString: URI,
        methods: HTTPMethod,
        body: Data? = nil,
        params: String? = nil,
    ) async throws -> Data {
        let fullURL = params == nil ? url.getUrlString(for: urlString) : url.getUrlString(for: urlString, with: params!)
        print(fullURL)
            
            guard let url = URL(string: fullURL) else {
                throw NetworkHandlerError.InvalidURL
            }
            
            var request = URLRequest(url: url)
            
            request.httpMethod = methods.rawValue
            request.httpBody = body
            
            let (data, response) = try await urlSession.data(for: request)
            
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
