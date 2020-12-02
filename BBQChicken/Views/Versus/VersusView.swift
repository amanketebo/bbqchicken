//
//  ContentView.swift
//  BBQChicken
//
//  Created by Amanuel Ketebo on 11/19/20.
//

import SwiftUI

struct VersusView: View {
    // MARK: - Properties
    
    @ObservedObject var viewModel = VersusViewModel()

    @State var isPlayerOneAllPlayersViewPresented = false
    @State var isPlayerTwoAllPlayersViewPresented = false

    var body: some View {
        let edgeInsets = EdgeInsets(top: 25, leading: 0, bottom: 25, trailing: 0)

        NavigationView {
            List {
                HStack {
                    Spacer()
                    Button(action: {
                            isPlayerOneAllPlayersViewPresented = true
                    }, label: {
                        let playerViewModel = VersusPlayerViewModel(player: viewModel.playerOne)
                        VersusPlayerView(viewModel: playerViewModel)
                    })
                    .sheet(isPresented: $isPlayerOneAllPlayersViewPresented) {
                        let allPlayersViewModel = AllPlayersViewModel(statsService: StatsService(),
                                                                      playersCache: viewModel.allPlayersCache)
                        AllPlayersView(viewModel: allPlayersViewModel, onPlayerSelection: {
                            viewModel.playerOne = $0
                        })
                    }
                    Spacer()
                }
                .padding(edgeInsets)

                HStack {
                    Spacer()
                    Button(action: {
                            isPlayerTwoAllPlayersViewPresented = true
                    }, label: {
                        let playerViewModel = VersusPlayerViewModel(player: viewModel.playerTwo)
                        VersusPlayerView(viewModel: playerViewModel)
                    })
                    .sheet(isPresented: $isPlayerTwoAllPlayersViewPresented) {
                        let allPlayersViewModel = AllPlayersViewModel(statsService: StatsService(),
                                                                      playersCache: viewModel.allPlayersCache)
                        AllPlayersView(viewModel: allPlayersViewModel, onPlayerSelection: {
                            viewModel.playerTwo = $0
                        })
                    }
                    Spacer()
                }
                .padding(edgeInsets)
            }
            .navigationBarTitle("🍗 BBQ Chicken")
        }
    }
}

struct VersusView_Previews: PreviewProvider {
    static var previews: some View {
        let player = Player(id: 1,
                            firstName: "Kobe",
                            lastName: "Bryant",
                            pointsPerGame: 25,
                            reboundsPerGame: 5,
                            assistsPerGame: 5)
        let emptyViewModel = VersusViewModel(playerOne: nil,
                                             playerTwo: nil)
        let fullViewModel = VersusViewModel(playerOne: player,
                                            playerTwo: player)
        Group {
            VersusView(viewModel: emptyViewModel)
                .previewDevice("iPhone X")
            VersusView(viewModel: fullViewModel)
                .previewDevice("iPhone SE (2nd generation)")
                .previewDisplayName("iPhone SE")
        }
    }
}
