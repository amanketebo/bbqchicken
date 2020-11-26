//
//  MockAllPlayersPublisher.swift
//  BBQChicken
//
//  Created by Amanuel Ketebo on 11/25/20.
//

import Foundation
import Combine

class MockAllPlayersPublisher: Publisher {
    // MARK: - Typealiases

    typealias Output = [Player]
    typealias Failure = Error

    // MARK: - Properties

    var allPlayers: [Player]

    // MARK: - Init

    init(allPlayers: [Player]) {
        self.allPlayers = allPlayers
    }

    // MARK: - Publisher

    func receive<S>(subscriber: S) where S : Subscriber, Failure == S.Failure, Output == S.Input {
        // We don't care about the demand at the moment
        let _ = subscriber.receive(allPlayers)
        subscriber.receive(completion: .finished)
    }
}
