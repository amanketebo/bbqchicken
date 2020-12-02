//
//  MockStatsService.swift
//  BBQChicken
//
//  Created by Amanuel Ketebo on 11/25/20.
//

import Foundation
import Combine

class MockStatsService: StatsServiceProtocol {
    var allPlayers: [Player] = [Player(id: 1,
                                            firstName: "Kobe",
                                            lastName: "Bryant",
                                            pointsPerGame: 25,
                                            reboundsPerGame: 5,
                                            assistsPerGame: 5),
                                     Player(id: 2,
                                            firstName: "Dwayne",
                                            lastName: "Wade",
                                            pointsPerGame: 20,
                                            reboundsPerGame: 5,
                                            assistsPerGame: 4),
                                     Player(id: 3,
                                            firstName: "James",
                                            lastName: "Harden",
                                            pointsPerGame: 28,
                                            reboundsPerGame: 1,
                                            assistsPerGame: 0)]

    var allPlayersPublisher: AnyPublisher<[Player], Error> {
        return MockAllPlayersPublisher(allPlayers: allPlayers).eraseToAnyPublisher()
    }
}
