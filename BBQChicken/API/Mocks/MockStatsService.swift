//
//  MockStatsService.swift
//  BBQChicken
//
//  Created by Amanuel Ketebo on 11/25/20.
//

import Foundation
import Combine

class MockStatsService: StatsServiceProtocol {
    var playersToReturn: [Player] = [Player(id: 1,
                                            firstName: "Kobe",
                                            lastName: "Bryant",
                                            pointsPerGame: 25,
                                            reboundsPerGame: 5,
                                            assistsPerGame: 5),
                                     Player(id: 2, firstName: "Dwayne",
                                            lastName: "Wade",
                                            pointsPerGame: 20,
                                            reboundsPerGame: 5,
                                            assistsPerGame: 4)]

    var allPlayersPublisher: AnyPublisher<[Player], Error> {
        return MockAllPlayersPublisher(allPlayers: playersToReturn).eraseToAnyPublisher()
    }
}
