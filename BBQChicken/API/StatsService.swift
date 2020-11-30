//
//  NBAStatsService.swift
//  BBQChicken
//
//  Created by Amanuel Ketebo on 11/19/20.
//

import Foundation
import Combine

protocol StatsServiceProtocol {
    var allPlayersPublisher: AnyPublisher<[Player], Error> { get }
}

class StatsService: ObservableObject, StatsServiceProtocol {
    // MARK: - Types

    enum ServiceError: Error {
        case general
    }

    // MARK: - Properties

    let session = URLSession(configuration: .default)

    // MARK: - Fetch

    var allPlayersPublisher: AnyPublisher<[Player], Error> {
        let playerIndexRequest = RequestFactory.request(for: .playerIndex)!

        return session.dataTaskPublisher(for: playerIndexRequest)
            .map(\.data)
            .decode(type: PlayerIndexResponse.self, decoder: JSONDecoder())
            .map { playerIndexResponse in
                playerIndexResponse.resultSets?.first?.rowSet.compactMap { Player(rowSetInfo: $0) } ?? []
            }
            .eraseToAnyPublisher()
    }
}
