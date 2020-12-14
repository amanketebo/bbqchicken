//
//  UserDataStore.swift
//  BBQChicken
//
//  Created by Amanuel Ketebo on 12/1/20.
//

import Foundation
import WidgetKit

class UserDataStore {
    // MARK: - Types

    private enum Keys {
        static let recentlySelectedPlayers = "recentlySelectedPlayers"
        static let lastSelectedPlayer = "lastSelectedPlayer"
        static let versusViewPlayers = "versusViewPlayers"
    }

    // MARK: - Properties

    var recentlySelectedPlayers: [Player] {
        guard let players = fetch(type: [Player].self, forKey: Keys.recentlySelectedPlayers) else {
            return []
        }

        return players.reversed()
    }

    var lastSelectedPlayer: Player? {
        return fetch(type: Player.self, forKey: Keys.lastSelectedPlayer)
    }

    var versusViewPlayers: [Player?] {
        return fetch(type: [Player?].self, forKey: Keys.versusViewPlayers) ?? []
    }

    private let recentSelectedPlayersLimit: Int
    private let userDefaults: UserDefaults?

    // MARK: - Init

    init(recentSelectedPlayersLimit: Int = 3,
         userDefaults: UserDefaults? = UserDefaults(suiteName: "group.bbqchicken")) {
        self.recentSelectedPlayersLimit = recentSelectedPlayersLimit
        self.userDefaults = userDefaults
    }

    // MARK: - Saving

    func save(_ player: Player) {
        save(lastSelectedPlayer: player)
        WidgetCenter.shared.reloadAllTimelines()
        updateRecentlySelectedPlayers(with: player)
    }

    func storeVersusViewPlayers(_ players: [Player?]) {
        store(value: players, forKey: Keys.versusViewPlayers)
    }

    private func save(lastSelectedPlayer: Player) {
        store(value: lastSelectedPlayer, forKey: Keys.lastSelectedPlayer)
    }

    private func updateRecentlySelectedPlayers(with player: Player) {
        let selectedPlayers = recentlySelectedPlayers

        guard !selectedPlayers.contains(player) else {
            return
        }

        var lastPlayersSaved = Array(selectedPlayers.suffix(recentSelectedPlayersLimit - 1))
        lastPlayersSaved.append(player)

        store(value: lastSelectedPlayer, forKey: Keys.recentlySelectedPlayers)
    }

    // MARK: - Helpers

    private func fetch<T: Codable>(type: T.Type, forKey key: String) -> T? {
        guard let userDefaults = userDefaults,
              let data = userDefaults.data(forKey: key) else {
            return nil
        }

        return try? JSONDecoder().decode(type, from: data)
    }

    private func store<T: Codable>(value: T, forKey key: String) {
        guard let userDefaults = userDefaults else {
            return
        }

        do {
            let data = try JSONEncoder().encode(value)
            userDefaults.setValue(data, forKey: key)
        } catch {
            print("Failed to save value for key: \(value)")
        }
    }
}
