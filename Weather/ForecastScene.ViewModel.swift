//
//  ForecastScene.ViewModel.swift
//  Weather
//
//  Created by John Reid on 10/3/2022.
//

import Foundation

extension ForecastScene {
    class ViewModel: ObservableObject {
        
        struct Cell: Identifiable {
            var id: String { title }
            
            let title: String
            let detail: String
            let imageSystemName: String
            
        }
        
        var cells: [Cell] {
            [
                Cell(title: "Sydney", detail: "Cloudy", imageSystemName: "cloud.fill"),
                Cell(title: "Melbourne", detail: "Rain", imageSystemName: "cloud.rain.fill"),
                Cell(title: "Brisbane", detail: "Sunny", imageSystemName: "sun.max.fill")
            ]
        }
    }
}
