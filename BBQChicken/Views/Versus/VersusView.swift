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

    @State private var editMode = EditMode.inactive

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
                                viewModel.saveState()
                            })
                        }
                        Spacer()
                    }
                    .padding(EdgeInsets(top: 25, leading: 0, bottom: 25, trailing: 0))
                }
                .onMove(perform: move)
                .onDelete(perform: delete)
            }
            .navigationBarItems(leading: EditButton())
            .navigationBarTitle("🍗 BBQ Chicken")
            .listStyle(InsetListStyle())
            .onAppear {
                viewModel.fetchState()
            }
            .environment(\.editMode, $editMode)
        }
    }

    private func move(from source: IndexSet, to destination: Int) {
        viewModel.players.move(fromOffsets: source, toOffset: destination)
        viewModel.saveState()
    }

    private func delete(from indexSet: IndexSet) {
        viewModel.players.remove(atOffsets: indexSet)

        if viewModel.players.isEmpty {
            viewModel.players = VersusViewModel.initialPlayers
            editMode = .inactive
        }

        viewModel.saveState()
    }
}

struct VersusView_Previews: PreviewProvider {

    // MARK: - PreviewProvider

    static var previews: some View {
        let emptyViewModel = VersusViewModel(initialPlayers: [nil, nil])
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
        .environmentObject(AppFontFamilyProvider(fontFamily: .christmas))
    }
}
