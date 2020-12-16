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
                    if !viewModel.recentPlayers.isEmpty {
                        Section(header: Text("Recent")) {
                            ForEach(viewModel.recentPlayers, id: \.id) { recentPlayer in
                                let playerRow = PlayerRow(player: recentPlayer)
                                PlayerRowView(playerRow: playerRow) {
                                    savePlayerAndDismiss(recentPlayer)
                                }
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
        let playersCache = PlayersCache(allPlayers: [MockPlayers.kobeBryant,
                                                     MockPlayers.dwayneWade,
                                                     MockPlayers.jamesHarden])
        let viewModel = AllPlayersViewModel(statsService: MockStatsService(),
                                            playersCache: playersCache)
        AllPlayersView(viewModel: viewModel,
                       onPlayerSelection: nil)
            .environment(\.colorScheme, ColorScheme.dark)
            .environmentObject(AppFontFamilyProvider(fontFamily: .christmas))
    }
}
