//
//  UserDataStore.swift
//  BBQChicken
//
//  Created by Amanuel Ketebo on 12/1/20.
//

import Foundation

class UserDataStore {
    private enum Keys {
        static let recentlySelectedPlayers = "recentlySelectedPlayers"
    }

    let userDefaults: UserDefaults

    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }

    var recentlySelectedPlayers: [Player] {
        guard let playersData = userDefaults.data(forKey: Keys.recentlySelectedPlayers),
              let recentlySelectedPlayers = try? JSONDecoder().decode([Player].self, from: playersData) else {
            return []
        }

        return recentlySelectedPlayers
    }

    func save(_ player: Player) {
        var savedPlayers = self.recentlySelectedPlayers
        savedPlayers.append(player)

        do {
            let data = try JSONEncoder().encode(savedPlayers)
            userDefaults.setValue(data, forKey: Keys.recentlySelectedPlayers)
        } catch {
            print("Failed to save selected player")
        }
    }
}
