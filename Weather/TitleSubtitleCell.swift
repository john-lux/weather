//
//  TitleSubtitleCell.swift
//  Weather
//
//  Created by John Reid on 9/3/2022.
//

import SwiftUI

struct TitleSubtitleCell: View {
    
    let text: Text
    let detailText: Text
    
    var body: some View {
        VStack {
            text
                .font(.title)
            detailText
                .font(.callout)
                .foregroundColor(.secondary)
        }
        .padding(16)
    }
}

struct TitleSubtitleCell_Previews: PreviewProvider {
    static var previews: some View {
        TitleSubtitleCell(
            text: Text("19°C"),
            detailText: Text("Now")
        )
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
