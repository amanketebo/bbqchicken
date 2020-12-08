//
//  MockPlayers.swift
//  BBQChicken
//
//  Created by Amanuel Ketebo on 12/8/20.
//

import Foundation

enum MockPlayers {
    static let kobeBryant = Player(id: 1,
                                   firstName: "Kobe",
                                   lastName: "Bryant",
                                   pointsPerGame: 25,
                                   reboundsPerGame: 5.2,
                                   assistsPerGame: 4.7)

    static let dwayneWade = Player(id: 2,
                                   firstName: "Dwayne",
                                   lastName: "Wade",
                                   pointsPerGame: 22,
                                   reboundsPerGame: 4.7,
                                   assistsPerGame: 5.4)

    static let jamesHarden = Player(id: 3,
                                    firstName: "James",
                                    lastName: "Harden",
                                    pointsPerGame: 25.2,
                                    reboundsPerGame: 5.3,
                                    assistsPerGame: 6.3)

    static let calvinCambridge = Player(id: 4,
                                        firstName: "Calvin",
                                        lastName: "Cambridge",
                                        pointsPerGame: 38.5,
                                        reboundsPerGame: 2.3,
                                        assistsPerGame: 12)
}
