//
//  WeatherScene.swift
//  Weather
//
//  Created by John Reid on 9/3/2022.
//

import SwiftUI

struct WeatherScene: View {
    var body: some View {
        VStack(spacing: 8.0) {
            TitleSubtitleCell(
                text: Text("19°C"),
                detailText: Text("Now")
            )
            TitleSubtitleCell(
                text: Text("15°C"),
                detailText: Text("Min")
            )
            TitleSubtitleCell(
                text: Text("22°C"),
                detailText: Text("Max")
            )
        }
    }
}

struct WeatherScene_Previews: PreviewProvider {
    static var previews: some View {
        WeatherScene()
    }
}
