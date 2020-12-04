//
//  PlayerRow.swift
//  BBQChicken
//
//  Created by Amanuel Ketebo on 11/25/20.
//

import Foundation

struct PlayerRow {
    //  MARK: - Properties

    var text: String

    // MARK: - Init

    init(player: Player) {
        let lastNameFirstName = [player.lastName, player.firstName].compactMap { return $0 }.joined(separator: ", ")
        text = lastNameFirstName
    }
}
