//
//  Site.swift
//  Weather
//
//  Created by John Reid on 9/3/2022.
//

import Foundation

struct Site: Decodable {
    let id: Int
    let name: String
    let main: Main
    let wind: Wind
    
    struct Main {
        let temperature: Double
        let feelsLikeTemperature: Double
        let minimumTemperature: Double
        let maximumTemperature: Double
    }
    
    struct Wind {
        let speed: Double
        let degrees: Double
    }
}

extension Site.Main: Decodable {
    enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case feelsLikeTemperature = "feels_like"
        case minimumTemperature = "temp_min"
        case maximumTemperature = "temp_max"
        
    }
}

extension Site.Wind: Decodable {
    enum CodingKeys: String, CodingKey {
        case speed
        case degrees = "deg"
    }
}
