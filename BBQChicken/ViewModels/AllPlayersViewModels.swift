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

    @Published var filteredPlayers: [Player] = []

    private var allPlayers: [Player] = []
    private var statsService: StatsServiceProtocol
    private var subscriptions = Set<AnyCancellable>()

    // MARK: - Init

    init(statsService: StatsServiceProtocol) {
        self.statsService = statsService
    }

    func fetchAllPlayersIfNeeded() {
        guard allPlayers.isEmpty else {
            filteredPlayers = allPlayers
            return
        }

        statsService.allPlayersPublisher
            .receive(on: DispatchQueue.main)
            .sink { completion in
                print(completion)
            } receiveValue: { allPlayers in
                self.allPlayers = allPlayers
                self.filteredPlayers = allPlayers
            }
            .store(in: &subscriptions)
    }

    func filterPlayers(for searchText: String) {
        let searchTextWithoutSpaces = searchText.trimmingCharacters(in: .whitespaces).lowercased()

        if searchText.isEmpty {
            filteredPlayers = allPlayers
        } else {
            filteredPlayers = allPlayers.filter {
                $0.fullName.trimmingCharacters(in: .whitespaces).lowercased().contains(searchTextWithoutSpaces)
            }
        }
    }
}

