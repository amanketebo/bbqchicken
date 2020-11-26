//
//  ContentView.swift
//  BBQChicken
//
//  Created by Amanuel Ketebo on 11/19/20.
//

import SwiftUI

struct VersusView: View {
    @ObservedObject var viewModel = VersusViewModel()

    @State var isPlayerOneAllPlayersViewPresented = false
    @State var isPlayerTwoAllPlayersViewPresented = false

    var body: some View {
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
                        AllPlayersView(viewModel: viewModel, updatingPlayer: .one)
                    }
                    Spacer()
                }
                .padding(.top, 25)
                .padding(.bottom, 25)

                HStack {
                    Spacer()
                    Button(action: {
                            isPlayerTwoAllPlayersViewPresented = true
                    }, label: {
                        let playerViewModel = VersusPlayerViewModel(player: viewModel.playerTwo)
                        VersusPlayerView(viewModel: playerViewModel)
                    })
                    .sheet(isPresented: $isPlayerTwoAllPlayersViewPresented) {
                        AllPlayersView(viewModel: viewModel, updatingPlayer: .two)
                    }
                    Spacer()
                }
                .padding(.top, 25)
                .padding(.bottom, 25)
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
                                             playerTwo: nil,
                                             statsService: MockStatsService())
        let fullViewModel = VersusViewModel(playerOne: player,
                                            playerTwo: player,
                                            statsService: MockStatsService())
        Group {
            VersusView(viewModel: emptyViewModel)
                .previewDevice("iPhone X")
            VersusView(viewModel: fullViewModel)
                .previewDevice("iPhone SE (2nd generation)")
                .previewDisplayName("iPhone SE")
        }
    }
}
