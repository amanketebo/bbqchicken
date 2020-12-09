//
//  StatRowViewModel.swift
//  BBQChicken
//
//  Created by Amanuel Ketebo on 11/23/20.
//

import Foundation
import WidgetKit

struct StatRow: Identifiable {
    // MARK: - Properties

    var title: String
    var detail: String

    var id: String {
        return title + detail
    }

    // MARK: - Init

    init(stat: Stat,
         widgetFamily: WidgetFamily? = nil,
         isEmptyWidget: Bool = false) {
        title = StatRow.title(for: stat, widgetFamily: widgetFamily)
        detail = StatRow.detail(for: stat, isEmptyWidget: isEmptyWidget)
    }

    static func title(for stat: Stat, widgetFamily: WidgetFamily?) -> String {
        switch (stat, widgetFamily) {
        case (_, .systemSmall?):
            return StatRow.emoji(for: stat)

        case (.pointsAverage, _):
            return "\(StatRow.emoji(for: stat)) Points"

        case (.reboundsAverage, _):
            return "\(StatRow.emoji(for: stat)) Rebounds"

        case (.assistsAverage, _):
            return "\(StatRow.emoji(for: stat)) Assists"
        }
    }

    static func detail(for stat: Stat, isEmptyWidget: Bool) -> String {
        switch stat {
        case .pointsAverage(let statPerGame),
             .reboundsAverage(let statPerGame),
             .assistsAverage(let statPerGame):
            if isEmptyWidget {
                return "--"
            } else if let statPerGame = statPerGame {
                return "\(statPerGame) \(StatRow.abbreviation(for: stat))"
            } else {
                return "N/A"
            }
        }
    }

    static func emoji(for stat: Stat) -> String {
        switch stat {
        case .pointsAverage:
            return "🔢"

        case .reboundsAverage:
            return "🏀"

        case .assistsAverage:
            return "🛂"
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
