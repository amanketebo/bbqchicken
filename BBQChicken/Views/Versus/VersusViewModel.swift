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
    @Published var isPresentedBindings: [Bool]
    // TODO: (Aman) Move to environment object
    var allPlayersCache: PlayersCache

    // MARK: - Init

    init(initialEmptyPlayers: Int,
         allPlayersCache: PlayersCache = PlayersCache()) {
        var setUpPlayers: [Player?] = []
        var setUpIsPresentedBindings: [Bool] = []

        for _ in 0..<initialEmptyPlayers {
            setUpPlayers.append(nil)
            setUpIsPresentedBindings.append(false)
        }

        self.players = setUpPlayers
        self.isPresentedBindings = setUpIsPresentedBindings
        self.allPlayersCache = allPlayersCache
    }

    init(initialPlayers: [Player?],
         allPlayersCache: PlayersCache = PlayersCache()) {
        self.players = initialPlayers
        self.isPresentedBindings = initialPlayers.map { _ in false }
        self.allPlayersCache = allPlayersCache
    }
}
