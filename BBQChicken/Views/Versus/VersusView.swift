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
    @State var isAllPlayersPresented = false

    // MARK: - View

    var body: some View {
        NavigationView {
            List {
                ForEach(Array(viewModel.players.enumerated()), id: \.offset) { index, player in
                    HStack {
                        Spacer()
                        Button(action: { isAllPlayersPresented = true }, label: {
                            VersusPlayerView(viewModel: VersusPlayerViewModel(player: player))
                        })
                        .sheet(isPresented: self.$isAllPlayersPresented) {
                            AllPlayersView(viewModel: AllPlayersViewModel(playersCache: viewModel.allPlayersCache),
                                           onPlayerSelection: { updatedPlayer in
                                self.viewModel.players[index] = updatedPlayer
                            })
                        }
                        Spacer()
                    }
                    .padding(EdgeInsets(top: 25, leading: 0, bottom: 25, trailing: 0))
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
