//
//  WidgetPlayerViewModel.swift
//  BBQChickenWidgetExtension
//
//  Created by Amanuel Ketebo on 12/8/20.
//

import Foundation
import WidgetKit

struct WidgetPlayerViewModel {
    let fullNameText: String
    let statRows: [StatRow]

    init(player: Player?,
         widgetFamily: WidgetFamily) {
        fullNameText = player?.fullName ?? "--"

        var availableStats: [Stat] = []
        availableStats.append(.pointsAverage(player?.pointsPerGame ?? -1))
        availableStats.append(.reboundsAverage(player?.reboundsPerGame ?? -1))
        availableStats.append(.assistsAverage(player?.assistsPerGame ?? -1))
        statRows = availableStats.map { StatRow(stat: $0, widgetFamily: widgetFamily, isEmptyWidget: player == nil) }
    }
}
