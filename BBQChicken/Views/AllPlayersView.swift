//
//  AllPlayersView.swift
//  BBQChicken
//
//  Created by Amanuel Ketebo on 11/25/20.
//

import SwiftUI

struct AllPlayersView: View {
    // MARK: - Types

    enum UpdatingPlayer {
        case one
        case two
    }

    // MARK: - Properties

    @ObservedObject var viewModel: VersusViewModel
    var updatingPlayer: UpdatingPlayer
    
    @Environment(\.presentationMode) private var presentationMode

    var body: some View {
        NavigationView {
            VStack {
                SearchBar(placeholder: "Search",
                          onTextUpdate: { updatedText in
                    viewModel.filterPlayers(for: updatedText)
                })
                List(viewModel.filteredPlayers, id: \.id) { player in
                    let allPlayerViewModel = AllPlayerViewModel(player: player)
                    Text(allPlayerViewModel.text)
                        .onTapGesture {
                            updatePlayer(with: player)
                            presentationMode.wrappedValue.dismiss()
                        }
                }
                .onAppear {
                    self.viewModel.fetchAllPlayersIfNeeded()
                }
            }
            .navigationBarTitle("⛹🏽‍♂️ All NBA Players")
        }
    }

    private func updatePlayer(with newPlayer: Player) {
        switch updatingPlayer {
        case .one:
            viewModel.playerOne = newPlayer

        case .two:
            viewModel.playerTwo = newPlayer
        }
    }
}

struct AllPlayersView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = VersusViewModel(playerOne: nil,
                                        playerTwo: nil,
                                        statsService: MockStatsService())
        AllPlayersView(viewModel: viewModel, updatingPlayer: .one)
    }
}
