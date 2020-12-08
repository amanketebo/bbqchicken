//
//  MockStatsService.swift
//  BBQChicken
//
//  Created by Amanuel Ketebo on 11/25/20.
//

import Foundation
import Combine

class MockStatsService: StatsServiceProtocol {
    var allPlayers: [Player] = [MockPlayers.kobeBryant,
                                MockPlayers.dwayneWade,
                                MockPlayers.jamesHarden]

    var allPlayersPublisher: AnyPublisher<[Player], Error> {
        return MockAllPlayersPublisher(allPlayers: allPlayers).eraseToAnyPublisher()
    }
}
