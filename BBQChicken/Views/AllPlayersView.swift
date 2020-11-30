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

    @ObservedObject private var viewModel = AllPlayersViewModel(statsService: StatsService())
    @Environment(\.presentationMode) private var presentationMode

    var body: some View {
        NavigationView {
            VStack {
                SearchBar(placeholder: "Search",
                          onTextUpdate: { updatedText in
                    viewModel.filterPlayers(for: updatedText)
                })
                List(viewModel.filteredPlayers, id: \.id) { player in
                    let playerRow = PlayerRow(player: player)
                    Text(playerRow.text)
                        .onTapGesture {
                            onPlayerSelection?(player)
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
}

struct AllPlayersView_Previews: PreviewProvider {
    static var previews: some View {
        AllPlayersView(onPlayerSelection: nil)
    }
}
