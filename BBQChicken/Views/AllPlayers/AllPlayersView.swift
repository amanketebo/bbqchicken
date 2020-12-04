//
//  AllPlayersView.swift
//  BBQChicken
//
//  Created by Amanuel Ketebo on 11/25/20.
//

import SwiftUI

struct AllPlayersView: View {
    // MARK: - Properties

    @ObservedObject var viewModel: AllPlayersViewModel
    var onPlayerSelection: ((Player) -> Void)?

    @Environment(\.presentationMode) private var presentationMode

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                SearchBar(placeholder: "Search",
                          onTextUpdate: { updatedText in
                    viewModel.filter(for: updatedText)
                })
                List {
                    Section(header: Text("Recent")) {
                        ForEach(viewModel.recentPlayers, id: \.id) { recentPlayer in
                            let playerRow = PlayerRow(player: recentPlayer)
                            PlayerRowView(playerRow: playerRow) {
                                savePlayerAndDismiss(recentPlayer)
                            }
                        }
                    }

                    Section(header: Text("All")) {
                        ForEach(viewModel.allPlayers, id: \.id) { player in
                            let playerRow = PlayerRow(player: player)
                            PlayerRowView(playerRow: playerRow) {
                                savePlayerAndDismiss(player)
                            }
                        }
                    }
                }
                .listStyle(InsetGroupedListStyle())
                .onAppear {
                    self.viewModel.populatePlayers()
                }
            }
            .navigationBarTitle("⛹🏽‍♂️ All NBA Players")
        }
    }

    func savePlayerAndDismiss(_ player: Player) {
        onPlayerSelection?(player)
        viewModel.save(player)
        presentationMode.wrappedValue.dismiss()
    }
}

struct AllPlayersView_Previews: PreviewProvider {
    static var previews: some View {
        let playersCache = PlayersCache(allPlayers: [Player(id: 1,
                                                            firstName: "Kobe",
                                                            lastName: "Bryant",
                                                            pointsPerGame: 25,
                                                            reboundsPerGame: 5,
                                                            assistsPerGame: 5),
                                                     Player(id: 2,
                                                            firstName: "Dwayne",
                                                            lastName: "Wade",
                                                            pointsPerGame: 20,
                                                            reboundsPerGame: 5,
                                                            assistsPerGame: 4),
                                                     Player(id: 3,
                                                            firstName: "James",
                                                            lastName: "Harden",
                                                            pointsPerGame: 28,
                                                            reboundsPerGame: 1,
                                                            assistsPerGame: 0)])
        let allPlayersViewModel = AllPlayersViewModel(statsService: MockStatsService(),
                                                      playersCache: playersCache)
        AllPlayersView(viewModel: allPlayersViewModel,
                       onPlayerSelection: nil)
            .environment(\.colorScheme, ColorScheme.dark)
    }
}
