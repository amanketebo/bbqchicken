//
//  PlayersCache.swift
//  BBQChicken
//
//  Created by Amanuel Ketebo on 12/1/20.
//

import Foundation

class PlayersCache {
    // MARK: - Properties

    var allPlayers: [Player] = []

    // MARK: - Init
    
    init(allPlayers: [Player] = []) {
        self.allPlayers = allPlayers
    }
}
