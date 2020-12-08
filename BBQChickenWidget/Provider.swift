//
//  Provider.swift
//  BBQChicken
//
//  Created by Amanuel Ketebo on 12/8/20.
//

import Foundation
import WidgetKit

struct Provider: TimelineProvider {
    // Replace mock player with one from app group or userDefaults
    let player = MockPlayers.kobeBryant

    // MARK: - TimelineProvider

    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), player: player)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), player: player)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> ()) {
        completion(Timeline(entries: [SimpleEntry(date: Date(), player: player)],
                            policy: .never))
    }
}
