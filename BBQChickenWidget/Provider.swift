//
//  Provider.swift
//  BBQChicken
//
//  Created by Amanuel Ketebo on 12/8/20.
//

import Foundation
import WidgetKit

struct Provider: TimelineProvider {
    let userDataStore = UserDataStore()

    // MARK: - TimelineProvider

    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), player: MockPlayers.calvinCambridge)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(),
                                player: userDataStore.lastSelectedPlayer ?? MockPlayers.calvinCambridge)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> ()) {
        completion(Timeline(entries: [SimpleEntry(date: Date(), player: userDataStore.lastSelectedPlayer)],
                            policy: .never))
    }
}
