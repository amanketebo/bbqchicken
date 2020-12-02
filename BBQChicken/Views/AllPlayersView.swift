//
//  AllPlayersView.swift
//  BBQChicken
//
//  Created by Amanuel Ketebo on 11/25/20.
//

import SwiftUI

struct AllPlayersView: View {
    // MARK: - Properties

    var onPlayerSelection: ((Player) -> Void)?
    @ObservedObject var viewModel = AllPlayersViewModel(statsService: StatsService())

    @Environment(\.presentationMode) private var presentationMode

    var body: some View {
        NavigationView {
            VStack {
                SearchBar(placeholder: "Search",
                          onTextUpdate: { updatedText in
                    viewModel.filter(for: updatedText)
                })
                List {
                    Section(header: Text("Recent")) {
                        ForEach(viewModel.recentPlayers, id: \.id) { recentPlayer in
                            let playerRow = PlayerRow(player: recentPlayer)
                            Text(playerRow.text)
                                .onTapGesture {
                                    onPlayerSelection?(recentPlayer)
                                    viewModel.save(recentPlayer)
                                    presentationMode.wrappedValue.dismiss()
                                }
                        }
                    }

                    Section(header: Text("All")) {
                        ForEach(viewModel.allPlayers, id: \.id) { player in
                            let playerRow = PlayerRow(player: player)
                            Text(playerRow.text)
                                .onTapGesture {
                                    onPlayerSelection?(player)
                                    viewModel.save(player)
                                    presentationMode.wrappedValue.dismiss()
                                }
                        }
                    }
                }
                .onAppear {
                    self.viewModel.populatePlayers()
                }
            }
            .navigationBarTitle("⛹🏽‍♂️ All NBA Players")
        }
    }
}

struct AllPlayersView_Previews: PreviewProvider {
    static var previews: some View {
        let allPlayersViewModel = AllPlayersViewModel(statsService: MockStatsService())
        AllPlayersView(onPlayerSelection: nil, viewModel: allPlayersViewModel)
    }
}
