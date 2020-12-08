//
//  VersusPlayerViewModel.swift
//  BBQChicken
//
//  Created by Amanuel Ketebo on 11/23/20.
//

import Foundation
import WidgetKit

struct VersusPlayerViewModel {
    // MARK: - Type

    enum Layout {
        case compact
        case expanded
    }

    // MARK: - Properties

    let initialsText: String
    let fullNameText:  String
    let statRows: [StatRow]
    let layout: Layout
    
    // MARK: - Init

    init(player: Player?, widgetFamily: WidgetFamily? = nil) {
        let firstInitial = player?.firstName?.first.flatMap { String($0) } ?? ""
        let lastInitial = player?.lastName?.first.flatMap { String($0) } ?? ""
        initialsText = firstInitial.capitalized + lastInitial.capitalized

        fullNameText = player?.fullName ?? "Pick a NBA Player"

        var availableStats: [Stat] = []
        player?.pointsPerGame.flatMap { availableStats.append(.pointsAverage($0)) }
        player?.reboundsPerGame.flatMap { availableStats.append(.reboundsAverage($0)) }
        player?.assistsPerGame.flatMap { availableStats.append(.assistsAverage($0)) }
        statRows = availableStats.map { StatRow(stat: $0, widgetFamily: widgetFamily) }

        layout = statRows.isEmpty ? .expanded : .compact
    }
}
