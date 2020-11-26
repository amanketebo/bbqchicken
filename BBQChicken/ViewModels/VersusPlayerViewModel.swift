//
//  VersusPlayerViewModel.swift
//  BBQChicken
//
//  Created by Amanuel Ketebo on 11/23/20.
//

import Foundation

struct VersusPlayerViewModel {
    // MARK: - Type

    enum Layout {
        case compact
        case expanded
    }

    // MARK: - Properties

    let initialsText: String
    let fullNameText:  String
    let statRowViewModels: [StatRowViewModel]
    let layout: Layout
    
    // MARK: - Init

    init(player: Player?) {
        let firstInitial = player?.firstName?.first.flatMap { String($0) } ?? ""
        let lastInitial = player?.lastName?.last.flatMap { String($0) } ?? ""
        initialsText = firstInitial.capitalized + lastInitial.capitalized

        fullNameText = player?.fullName ?? "Pick a NBA Player"

        var availableStats: [Stat] = []
        player?.pointsPerGame.flatMap { availableStats.append(.pointsAverage($0)) }
        player?.reboundsPerGame.flatMap { availableStats.append(.reboundsAverage($0)) }
        player?.assistsPerGame.flatMap { availableStats.append(.assistsAverage($0)) }
        statRowViewModels = availableStats.map { StatRowViewModel(stat: $0) }

        layout = statRowViewModels.isEmpty ? .expanded : .compact
    }
}
