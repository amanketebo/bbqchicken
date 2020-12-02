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
    private var playersCache: PlayersCache
    private var subscriptions = Set<AnyCancellable>()

    // MARK: - Init

    init(statsService: StatsServiceProtocol,
         playersCache: PlayersCache) {
        self.statsService = statsService
        self.playersCache = playersCache
    }

    // MARK: - Set Up

    func populatePlayers() {
        recentPlayers = userDataStore.recentlySelectedPlayers
        allPlayers = playersCache.allPlayers
        fetchAllPlayersIfNeeded()
    }

    // MARK: Fetching

    func fetchAllPlayersIfNeeded() {
        guard playersCache.allPlayers.isEmpty else {
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

    private func update(allPlayers: [Player]) {
        playersCache.allPlayers = allPlayers
        self.allPlayers = allPlayers
    }

    // MARK: - Filtering

    func filter(for searchText: String) {
        let searchTextWithoutSpaces = searchText.trimmingCharacters(in: .whitespaces).lowercased()

        if searchText.isEmpty {
            recentPlayers = userDataStore.recentlySelectedPlayers
            allPlayers = playersCache.allPlayers
        } else {
            let filter: (Player) -> Bool = { player in
                player.fullName.trimmingCharacters(in: .whitespaces).lowercased().contains(searchTextWithoutSpaces)
            }

            recentPlayers = userDataStore.recentlySelectedPlayers.filter(filter)
            allPlayers = playersCache.allPlayers.filter(filter)
        }
    }

    // MARK: - Save

    func save(_ player: Player) {
        userDataStore.save(player)
    }
}
