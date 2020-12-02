//
//  VersusPlayerView.swift
//  BBQChicken
//
//  Created by Amanuel Ketebo on 11/25/20.
//

import SwiftUI

struct VersusPlayerView: View {
    // MARK: - Properties
    
    var viewModel: VersusPlayerViewModel

    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            switch viewModel.layout {
            case .compact:
                HStack {
                    InitialsView(text: viewModel.initialsText)
                        .frame(width: 75, height: 75, alignment: .center)
                    Text(viewModel.fullNameText)
                        .font(.title)
                        .foregroundColor(.black)
                    Spacer()
                }

            case .expanded:
                InitialsView(text: viewModel.initialsText)
                    .frame(width: 150, height: 150, alignment: .center)
                Text(viewModel.fullNameText)
                    .font(.title)
                    .foregroundColor(.black)
            }

            if !viewModel.statRows.isEmpty {
                ForEach(viewModel.statRows) { viewModel in
                    HStack {
                        Text(viewModel.title)
                            .fontWeight(.medium)
                        Spacer()
                        Text(viewModel.detail)
                            .fontWeight(.bold)
                    }
                }
            }
        }
    }
}

struct VersusPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        let player = Player(id: 1,
                            firstName: "Kobe",
                            lastName: "Bryant",
                            pointsPerGame: 25,
                            reboundsPerGame: 5,
                            assistsPerGame: 5)
        let viewModel = VersusPlayerViewModel(player: player)
        VersusPlayerView(viewModel: viewModel)
            .previewLayout(.sizeThatFits)
    }
}
