//
//  AllPlayerViewModels.swift
//  BBQChicken
//
//  Created by Amanuel Ketebo on 11/30/20.
//

import Foundation
import Combine

class AllPlayersViewModel: ObservableObject {
    // MARK: - Properties

    @Published var recentPlayers: [Player] = []
    @Published var allPlayers: [Player] = []

    var userDataStore = UserDataStore(userDefaults: .standard)

    private var statsService: StatsServiceProtocol
    private var subscriptions = Set<AnyCancellable>()

    // MARK: - Init

    init(statsService: StatsServiceProtocol) {
        self.statsService = statsService
    }

    func populatePlayers() {
        recentPlayers = userDataStore.recentlySelectedPlayers
        allPlayers = statsService.allPlayers
        fetchAllPlayersIfNeeded()
    }

    func fetchAllPlayersIfNeeded() {
        guard statsService.allPlayers.isEmpty else {
            return
        }

        statsService.allPlayersPublisher
            .receive(on: DispatchQueue.main)
            .sink { completion in
                print(completion)
            } receiveValue: { allPlayers in
                self.update(allPlayers: allPlayers)
            }
            .store(in: &subscriptions)
    }

    func filter(for searchText: String) {
        let searchTextWithoutSpaces = searchText.trimmingCharacters(in: .whitespaces).lowercased()

        if searchText.isEmpty {
            recentPlayers = userDataStore.recentlySelectedPlayers
            allPlayers = statsService.allPlayers
        } else {
            let filter: (Player) -> Bool = { player in
                player.fullName.trimmingCharacters(in: .whitespaces).lowercased().contains(searchTextWithoutSpaces)
            }

            recentPlayers = userDataStore.recentlySelectedPlayers.filter(filter)
            allPlayers = statsService.allPlayers.filter(filter)
        }
    }

    func save(_ player: Player) {
        userDataStore.save(player)
    }

    private func update(allPlayers: [Player]) {
        statsService.allPlayers = allPlayers
        self.allPlayers = allPlayers
    }
}

