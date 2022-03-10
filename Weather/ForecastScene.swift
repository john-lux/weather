//
//  ForecastScene.swift
//  Weather
//
//  Created by John Reid on 10/3/2022.
//

import SwiftUI

struct ForecastScene: View {
    
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.cells) { cell in
                NavigationLink(
                    destination: {
                        //
                    }
                ) {
                    HStack {
                        Text(cell.title)
                        Spacer()
                        Text(cell.detail)
                            .foregroundColor(.secondary)
                        Image(systemName: cell.imageSystemName)
                    }
                }
            }
            .navigationTitle("Forecast")
            .listStyle(.insetGrouped)
        }
    }
}

struct ForecastScene_Previews: PreviewProvider {
    static var previews: some View {
        ForecastScene()
    }
}
