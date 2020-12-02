//
//  StatRowViewModel.swift
//  BBQChicken
//
//  Created by Amanuel Ketebo on 11/23/20.
//

import Foundation

struct StatRow: Identifiable {
    // MARK: - Properties

    var title: String
    var detail: String

    var id: String {
        return title + detail
    }

    // MARK: - Init

    init(stat: Stat) {
        let statAbbreviation = StatRow.abbreviation(for: stat)

        switch stat {
        case .pointsAverage(let pointsPerGame):
            let pointsPerGameString = String(pointsPerGame)
            title = "🔢 Points"
            detail = "\(pointsPerGameString) \(statAbbreviation)"

        case .reboundsAverage(let reboundsPerGame):
            title = "🏀 Rebounds"
            detail = "\(reboundsPerGame) \(statAbbreviation)"

        case .assistsAverage(let assistsPerGame):
            title = "🛂 Assists"
            detail = "\(assistsPerGame) \(statAbbreviation)"
        }
    }

    static func abbreviation(for stat: Stat) -> String {
        switch stat {
        case .pointsAverage:
            return "ppg"

        case .reboundsAverage:
            return "rpg"

        case .assistsAverage:
            return "apg"
        }
    }
}
