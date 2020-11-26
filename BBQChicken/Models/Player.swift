//
//  Player.swift
//  BBQChicken
//
//  Created by Amanuel Ketebo on 11/23/20.
//

import Foundation

struct Player: Hashable {
    // MARK: - Properties

    var id: Int
    var firstName: String?
    var lastName: String?
    var pointsPerGame: Float?
    var reboundsPerGame: Float?
    var assistsPerGame: Float?

    var fullName: String {
        let firstName = self.firstName ?? ""
        let lastName = self.lastName ?? ""

        return firstName + " " + lastName
    }

    // MARK: - Inits

    init(rowSetInfo: PlayerIndexResponse.RowSetInfo) {
        id = rowSetInfo.playerID
        firstName = rowSetInfo.firstName
        lastName = rowSetInfo.lastName
        pointsPerGame = rowSetInfo.pointsPerGame
        assistsPerGame = rowSetInfo.assistsPerGame
        reboundsPerGame = rowSetInfo.reboundsPerGame
    }

    init(id: Int,
         firstName: String,
         lastName: String,
         pointsPerGame: Float?,
         reboundsPerGame: Float?,
         assistsPerGame: Float?) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.pointsPerGame = pointsPerGame
        self.reboundsPerGame = reboundsPerGame
        self.assistsPerGame = assistsPerGame
    }

    // MARK: - Hashable

    static func == (lhs: Player, rhs: Player) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
