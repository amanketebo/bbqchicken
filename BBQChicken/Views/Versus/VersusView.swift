//
//  ContentView.swift
//  BBQChicken
//
//  Created by Amanuel Ketebo on 11/19/20.
//

import SwiftUI

struct VersusView: View {

    // MARK: - Properties

    @ObservedObject var viewModel: VersusViewModel

    // MARK: - View

    var body: some View {
        let edgeInsets = EdgeInsets(top: 25, leading: 0, bottom: 25, trailing: 0)

        NavigationView {
            List {
                ForEach(Array(viewModel.players.enumerated()), id: \.offset) { index, player in
                    HStack {
                        Spacer()
                        Button(action: { self.viewModel.isPresentedBindings[index] = true }, label: {
                            VersusPlayerView(viewModel: VersusPlayerViewModel(player: player))
                        })
                        .sheet(isPresented: self.$viewModel.isPresentedBindings[index]) {
                            AllPlayersView(viewModel: AllPlayersViewModel(playersCache: viewModel.allPlayersCache),
                                           onPlayerSelection: { updatedPlayer in
                                self.viewModel.players[index] = updatedPlayer
                            })
                        }
                        Spacer()
                    }
                    .padding(edgeInsets)
                }
            }
            .listStyle(InsetListStyle())
            .navigationBarTitle("🍗 BBQ Chicken")
        }
    }
}

struct VersusView_Previews: PreviewProvider {

    // MARK: - PreviewProvider

    static var previews: some View {
        let emptyViewModel = VersusViewModel(initialEmptyPlayers: 2)
        let populatedViewModel = VersusViewModel(initialPlayers: [MockPlayers.kobeBryant, MockPlayers.jamesHarden])

        Group {
            ForEach(ColorScheme.allCases, id: \.self) { colorScheme in
                let previewDevice = PreviewDevice(rawValue: "iPhone 12 Pro")
                
                VersusView(viewModel: emptyViewModel)
                    .previewDevice(previewDevice)
                    .environment(\.colorScheme, colorScheme)
                VersusView(viewModel: populatedViewModel)
                    .previewDevice(previewDevice)
                    .environment(\.colorScheme, colorScheme)
            }
        }
    }
}
