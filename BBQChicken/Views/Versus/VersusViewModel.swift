//
//  VersusViewModel.swift
//  BBQChicken
//
//  Created by Amanuel Ketebo on 11/23/20.
//

import Foundation
import Combine

class VersusViewModel: ObservableObject {

    // MARK: - Properties

    @Published var players: [Player?]
    // TODO: (Aman) Move to environment object
    var allPlayersCache: PlayersCache
    var userDataStore: UserDataStore

    // MARK: - Init

    init(initialPlayers: [Player?],
         allPlayersCache: PlayersCache = PlayersCache(),
         userDataStore: UserDataStore = UserDataStore()) {
        self.players = initialPlayers
        self.allPlayersCache = allPlayersCache
        self.userDataStore = userDataStore
    }

    // MARK: - Setting Up Players

    func fetchState() {
        let versusViewPlayers = userDataStore.versusViewPlayers
        players = versusViewPlayers.isEmpty ? [nil, nil] : versusViewPlayers
    }

    func saveState() {
        userDataStore.storeVersusViewPlayers(players)
    }
}
