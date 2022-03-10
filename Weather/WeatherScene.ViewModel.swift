//
//  WeatherScene.ViewModel.swift
//  Weather
//
//  Created by John Reid on 9/3/2022.
//

import Combine
import Foundation

extension WeatherScene {
    
    class ViewModel: ObservableObject {
        let textFieldPlaceHolder = "City"
        let buttonTitle = "Fetch"
        
        private var subscribers = Set<AnyCancellable>()
        
        @Published var alert: Alert?
        @Published var searchString: String = "Sydney"
        @Published var cells: [Cell] = [
            Cell(title: "X°C", subtitle: "Now"),
            Cell(title: "X°C", subtitle: "Min"),
            Cell(title: "X°C", subtitle: "Max"),
            Cell(title: "X km/h", subtitle: "Wind Speed")
        ]
    }
}

extension WeatherScene.ViewModel {
    
    struct Cell: Identifiable {
        let title: String
        let subtitle: String
        var id: String { subtitle }
    }
    
    enum Alert: Identifiable {
        case error(Error)
        var id: String { "Error" }
        
        var title: String {
            switch self {
            case .error:
                return "Error"
            }
        }
        
        var message: String {
            switch self {
            case .error(let error):
                return error.localizedDescription
            }
        }
    }
    
    func fetch() {
        fetchRequest()
    }
}

private extension WeatherScene.ViewModel {
    
    var request: URLRequest {
        API.weatherRequest(city: searchString, units: "metric")
    }

    func fetchRequest() {
        Fetch.publisher(request: request)
            .map { Self.cells(site: $0) }
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    debugPrint("finished")
                case .failure(let error):
                    debugPrint("error = \(error.localizedDescription)")
                    self.alert = .error(error)
                }
            } receiveValue: { self.cells = $0 }
            .store(in: &subscribers)
    }
    
    static func cells(site: Site) -> [Cell] {
        [
            Cell(title: "\(site.main.temperature)°C", subtitle: "Now"),
            Cell(title: "\(site.main.minimumTemperature)°C", subtitle: "Min"),
            Cell(title: "\(site.main.maximumTemperature)°C", subtitle: "Max"),
            Cell(title: "\(site.wind.speed) km/h", subtitle: "Wind Speed")
        ]
    }
}
