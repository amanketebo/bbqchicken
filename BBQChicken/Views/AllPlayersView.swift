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
            let navigationBarTitle = "⛹🏽‍♂️ All NBA Players"

            switch viewModel.loadState {
            case .loading:
                Text("Loading...")
                    .navigationBarTitle(navigationBarTitle)
                    .onAppear {
                        self.viewModel.fetchAllPlayersIfNeeded()
                    }

            case .loaded(let allPlayers):
                VStack {
                    SearchBar(placeholder: "Search",
                              onTextUpdate: { updatedText in
                        viewModel.filterPlayers(for: updatedText)
                    })
                    List(allPlayers, id: \.id) { player in
                        let playerRow = PlayerRow(player: player)
                        Text(playerRow.text)
                            .onTapGesture {
                                onPlayerSelection?(player)
                                presentationMode.wrappedValue.dismiss()
                            }
                    }
                }
                .navigationBarTitle(navigationBarTitle)
            }
        }
    }
}

struct AllPlayersView_Previews: PreviewProvider {
    static var previews: some View {
        AllPlayersView(onPlayerSelection: nil)
    }
}
