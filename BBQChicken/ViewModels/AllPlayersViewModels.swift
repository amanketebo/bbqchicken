//
//  AllPlayerViewModels.swift
//  BBQChicken
//
//  Created by Amanuel Ketebo on 11/30/20.
//

import Foundation
import Combine

enum LoadState<T> {
    case loading
    case loaded(T)
}

class AllPlayersViewModel: ObservableObject {
    // MARK: - Properties

    @Published var loadState: LoadState<[Player]> = .loading

    private var statsService: StatsServiceProtocol
    private var subscriptions = Set<AnyCancellable>()

    // MARK: - Init

    init(statsService: StatsServiceProtocol) {
        self.statsService = statsService
    }

    func fetchAllPlayersIfNeeded() {
        guard StatsService.allPlayers.isEmpty else {
            loadState = .loaded(StatsService.allPlayers)
            return
        }

        statsService.allPlayersPublisher
            .receive(on: DispatchQueue.main)
            .sink { completion in
                print(completion)
            } receiveValue: { allPlayers in
                StatsService.allPlayers = allPlayers
                self.loadState = .loaded(allPlayers)
            }
            .store(in: &subscriptions)
    }

    func filterPlayers(for searchText: String) {
        let searchTextWithoutSpaces = searchText.trimmingCharacters(in: .whitespaces).lowercased()

        if searchText.isEmpty {
            loadState = .loaded(StatsService.allPlayers)
        } else {
            loadState = .loaded(StatsService.allPlayers.filter {
                $0.fullName.trimmingCharacters(in: .whitespaces).lowercased().contains(searchTextWithoutSpaces)
            })
        }
    }
}
