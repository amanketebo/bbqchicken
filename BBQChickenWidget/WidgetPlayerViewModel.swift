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

        let availableStats: [Stat] = [.pointsAverage(player?.pointsPerGame),
                                      .reboundsAverage(player?.reboundsPerGame),
                                      .assistsAverage(player?.assistsPerGame)]
        statRows = availableStats.map { StatRow(stat: $0, widgetFamily: widgetFamily, isEmptyWidget: player == nil) }
    }
}
