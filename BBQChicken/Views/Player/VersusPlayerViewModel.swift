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
        case pickPlayer
        case showStats
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

        if let player = player {
            let availableStats: [Stat] = [.pointsAverage(player.pointsPerGame),
                                          .reboundsAverage(player.reboundsPerGame),
                                          .assistsAverage(player.assistsPerGame)]
            statRows = availableStats.map { StatRow(stat: $0, widgetFamily: widgetFamily) }
            layout = .showStats
        } else {
            statRows = []
            layout = .pickPlayer
        }
    }
}
