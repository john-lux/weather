//
//  Fetch.swift
//  Weather
//
//  Created by John Reid on 10/3/2022.
//

import Combine
import Foundation

enum Fetch {
    
    enum Error: LocalizedError {
        case notHTTPURLResponse
        case statusCode(data: Data, response: HTTPURLResponse)
        
        var errorDescription: String? {
            switch self {
                
            case .notHTTPURLResponse:
                return "No HTTP URL response"
            case .statusCode(data: let data, response: let response):
                let dataString = String(data: data, encoding: .utf8)
                return "Status code = \(response.statusCode), data = \(dataString ?? "nil")"
            }
        }
    }
    
    static func publisher<Output: Decodable>(request: URLRequest) -> AnyPublisher<Output, Swift.Error> {
        URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { (data: Data, response: URLResponse) in
                guard let httpURLResponse = response as? HTTPURLResponse
                else { throw Error.notHTTPURLResponse }
                guard httpURLResponse.statusCode < 400
                else { throw Error.statusCode(data: data, response: httpURLResponse)}
                return data
            }
            .mapError { error -> Swift.Error in
                guard case let .statusCode(data, _) = error as? Error,
                      let apiError = try? JSONDecoder().decode(API.Error.self, from: data)
                else { return error }
                return apiError
                
            }
            .decode(type: Output.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
