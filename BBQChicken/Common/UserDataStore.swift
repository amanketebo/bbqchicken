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

    var versusViewPlayers: [Player?] {
        return fetch(type: [Player?].self, forKey: Keys.versusViewPlayers) ?? []
    }

    var selectedPlayers: [Player] {
        guard let players = fetch(type: [Player].self, forKey: Keys.recentlySelectedPlayers) else {
            return []
        }

        return players.reversed()
    }

    var lastSelectedPlayer: Player? {
        return fetch(type: [Player].self, forKey: Keys.recentlySelectedPlayers)?.last
    }

    private let recentSelectedPlayersLimit: Int
    private let userDefaults: UserDefaults?

    // MARK: - Init

    init(recentSelectedPlayersLimit: Int = 3,
         userDefaults: UserDefaults? = UserDefaults(suiteName: "group.bbqchicken")) {
        self.recentSelectedPlayersLimit = recentSelectedPlayersLimit
        self.userDefaults = userDefaults
    }

    // MARK: - Storing

    func storeVersusViewPlayers(_ players: [Player?]) {
        store(value: players, forKey: Keys.versusViewPlayers)
    }

    func storeLastSelectedPlayer(_ player: Player) {
        storeSelectedPlayers(with: player)
    }

    private func storeSelectedPlayers(with player: Player) {
        let selectedPlayers = self.selectedPlayers

        guard !selectedPlayers.contains(player) else {
            return
        }

        var recentlySelectedPlayers = Array(selectedPlayers.suffix(recentSelectedPlayersLimit - 1))
        recentlySelectedPlayers.append(player)

        store(value: recentlySelectedPlayers, forKey: Keys.recentlySelectedPlayers)
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
