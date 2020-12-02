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

    @Published var playerOne: Player?
    @Published var playerTwo: Player?
    var allPlayersCache = PlayersCache()

    // MARK: - Init

    init(playerOne: Player? = nil,
         playerTwo: Player? = nil) {
        self.playerOne = playerOne
        self.playerTwo = playerTwo
    }
}
