//
//  API.swift
//  Weather
//
//  Created by John Reid on 10/3/2022.
//

import Foundation

enum API {
    
    static func weatherRequest(city: String, units: String) -> URLRequest {
        request(
            endURLPath: "weather",
            queryItems: [
                URLQueryItem(name: "q", value: city),
                URLQueryItem(name: "units", value: units)
            ]
        )
    }
    
    static func request(
        endURLPath: String,
        queryItems: [URLQueryItem]
    ) -> URLRequest {
        let apiKey = "28a085d2ea2074df1aa8e975b085e498"
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.openweathermap.org"
        urlComponents.path = "/data/2.5"
        urlComponents.queryItems = [
            URLQueryItem(name: "appid", value: apiKey)
        ]
        + queryItems
        return URLRequest(url: urlComponents.url!.appendingPathComponent(endURLPath))
    }

    struct Error: Decodable, LocalizedError {
        let statusCode: Int
        let message: String
        
        enum CodingKeys: String, CodingKey {
            case statusCode = "cod"
            case message
        }
        
        var errorDescription: String? {
            message
        }
    }
}
