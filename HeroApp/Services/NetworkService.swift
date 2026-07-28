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
        queryParams: [(name:String, value:String)]?
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
        queryParams: [(name:String, value:String)]? = nil
    ) async throws -> Data {
        let fullURL = params == nil ? url.getUrlString(for: urlString) : url.getUrlString(for: urlString, with: params!)
        
        guard var url = URL(string: fullURL) else {
            throw NetworkHandlerError.InvalidURL
        }
        
        if let query = queryParams {
            url = prepareURLWithQueryParams(query: query, url: fullURL)
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = methods.rawValue
        request.httpBody = body
        
        let (data, response) = try await urlSession.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkHandlerError.UnknownError
        }
        
        guard 200..<299 ~= httpResponse.statusCode else {
            if let error = try? JSONDecoder().decode(ResponseErrorMessage.self, from: data) {
                throw NetworkHandlerError.RequestError(error.error)
            }
            
            let responseBody = String(data: data, encoding: .utf8) ?? "No response body"
            throw NetworkHandlerError.RequestError("HTTP \(httpResponse.statusCode): \(responseBody)")
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

private extension NetworkService {
    func prepareURLWithQueryParams(query: [(name: String, value: String)], url: String) -> URL {
        guard var components = URLComponents(string: url) else { fatalError() }
        components.queryItems = query.map {
            URLQueryItem(name: $0.name, value: $0.value)
        }
        guard let url = components.url else {
            fatalError()
        }
        
        return url
    }
}
