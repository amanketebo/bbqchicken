//
//  UserDataStore.swift
//  BBQChicken
//
//  Created by Amanuel Ketebo on 12/1/20.
//

import Foundation

class UserDataStore {
    // MARK: - Types

    private enum Keys {
        static let recentlySelectedPlayers = "recentlySelectedPlayers"
    }

    // MARK: - Properties

    let userDefaults: UserDefaults
    let recentSelectedPlayersLimit: Int

    var recentlySelectedPlayers: [Player] {
        guard let playersData = userDefaults.data(forKey: Keys.recentlySelectedPlayers),
              let recentlySelectedPlayers = try? JSONDecoder().decode([Player].self, from: playersData) else {
            return []
        }

        return recentlySelectedPlayers.reversed()
    }

    // MARK: - Init

    init(userDefaults: UserDefaults,
         recentSelectedPlayersLimit: Int = 3) {
        self.userDefaults = userDefaults
        self.recentSelectedPlayersLimit = recentSelectedPlayersLimit
    }

    // MARK: - Saving

    func save(_ player: Player) {
        var savedPlayers = Array(self.recentlySelectedPlayers.suffix(recentSelectedPlayersLimit - 1))
        savedPlayers.append(player)

        do {
            let data = try JSONEncoder().encode(savedPlayers)
            userDefaults.setValue(data, forKey: Keys.recentlySelectedPlayers)
        } catch {
            print("Failed to save selected player")
        }
    }
}
