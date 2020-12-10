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

    // MARK: - Init

    init(initialEmptyPlayers: Int,
         allPlayersCache: PlayersCache = PlayersCache()) {
        var setUpPlayers: [Player?] = []

        for _ in 0..<initialEmptyPlayers {
            setUpPlayers.append(nil)
        }

        self.players = setUpPlayers
        self.allPlayersCache = allPlayersCache
    }

    init(initialPlayers: [Player],
         allPlayersCache: PlayersCache = PlayersCache()) {
        self.players = initialPlayers
        self.allPlayersCache = allPlayersCache
    }
}
