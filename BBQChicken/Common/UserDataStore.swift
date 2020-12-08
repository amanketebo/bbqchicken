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
    }

    // MARK: - Properties

    let recentSelectedPlayersLimit: Int

    var recentlySelectedPlayers: [Player] {
        guard let playersData = userDefaults?.data(forKey: Keys.recentlySelectedPlayers),
              let recentlySelectedPlayers = try? JSONDecoder().decode([Player].self, from: playersData) else {
            return []
        }

        return recentlySelectedPlayers.reversed()
    }

    var lastSelectedPlayer: Player? {
        guard let playersData = userDefaults?.data(forKey: Keys.lastSelectedPlayer) else {
            return nil
        }

        return try? JSONDecoder().decode(Player.self, from: playersData)
    }

    private let userDefaults: UserDefaults? = UserDefaults(suiteName: "group.bbqchicken")

    // MARK: - Init

    init(recentSelectedPlayersLimit: Int = 3) {
        self.recentSelectedPlayersLimit = recentSelectedPlayersLimit
    }

    // MARK: - Saving

    func save(_ player: Player) {
        save(lastSelectedPlayer: player)
        WidgetCenter.shared.reloadAllTimelines()
        updateRecentlySelectedPlayers(with: player)
    }

    private func save(lastSelectedPlayer: Player) {
        guard let userDefaults = userDefaults else {
            return
        }

        do {
            let data = try JSONEncoder().encode(lastSelectedPlayer)
            userDefaults.setValue(data, forKey: Keys.lastSelectedPlayer)
        } catch {
            print("Failed to save last selected player.")
        }
    }

    private func updateRecentlySelectedPlayers(with player: Player) {
        guard let userDefaults = userDefaults else {
            return
        }

        let selectedPlayers = recentlySelectedPlayers

        guard !selectedPlayers.contains(player) else {
            return
        }

        var lastPlayersSaved = Array(selectedPlayers.suffix(recentSelectedPlayersLimit - 1))
        lastPlayersSaved.append(player)

        do {
            let data = try JSONEncoder().encode(lastPlayersSaved)
            userDefaults.setValue(data, forKey: Keys.recentlySelectedPlayers)
        } catch {
            print("Failed to update recently selected players.")
        }
    }
}
