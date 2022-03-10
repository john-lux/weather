//
//  WeatherScene.swift
//  Weather
//
//  Created by John Reid on 9/3/2022.
//

import SwiftUI

struct WeatherScene: View {
    
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 8.0) {
                    TextField(
                        viewModel.textFieldPlaceHolder,
                        text: $viewModel.searchString
                    )
                        .textFieldStyle(.roundedBorder)
                    fetchButton
                    ForEach(viewModel.cells) { cell in
                        TitleSubtitleCell(
                            text: Text(cell.title),
                            detailText: Text(cell.subtitle)
                        )
                    }
                }
                .padding()
            }
            .navigationTitle("Weather")
            .alert(item: $viewModel.alert) { alert in
                Alert(
                    title: Text(alert.title),
                    message: Text(alert.message)
                )
            }
        }
    }
    
    var fetchButton: some View {
        Button(viewModel.buttonTitle) {
            withAnimation {
                viewModel.fetch()
            }
        }
    }
}

struct WeatherScene_Previews: PreviewProvider {
    static var previews: some View {
        WeatherScene()
    }
}
